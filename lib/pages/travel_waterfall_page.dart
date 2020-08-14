import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tourism/api/travel_dao.dart';
import 'package:flutter_tourism/model/travel_mode.dart';
import 'package:flutter_tourism/utils/navigator_util.dart';
import 'package:flutter_tourism/widgets/loading_container.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

const String _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const int PAGE_SIZE = 10;

class TravelWaterfallPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;
  const TravelWaterfallPage({Key key, this.travelUrl, this.groupChannelCode})
      : super(key: key);

  _TravelWaterfallPageState createState() => _TravelWaterfallPageState();
}

class _TravelWaterfallPageState extends State<TravelWaterfallPage> with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems;
  int pageIndex = 1;
  bool _loading = true;

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(index: ++pageIndex);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Null> _handleRefresh() {
    _loadData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingContainer(
            isLoading: _loading,
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  crossAxisCount: 4,
                  itemCount: travelItems?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) =>
                      _traveItem(index, travelItems[index]),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                ),
              ),
            )));
  }

  void _loadData({index = 1}) {
    TravelDao(widget?.travelUrl ?? _TRAVEL_URL, index, PAGE_SIZE,
            widget?.groupChannelCode)
        .then((TravelModel model) {
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        // 不等于null的话就插入合并,
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          // 否则直接替换
          travelItems = items;
        }
        _loading = false;
      });
    }).catchError((e) {
      _loading = false;
      print(e);
    });
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) return [];
    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  // 每一个card包含_itemImage和_infoText
  Widget _traveItem(int index, TravelItem item) => GestureDetector(
        onTap: () {
          setState(() {
            NavigatorUtil.push(
                context,
                WebViewWidget(
                  url: item.article?.urls[0]?.h5Url,
                  title: item.article?.pois[0]?.poiName ?? '详情',
                ));
          });
        },
        child: Card(
          child: PhysicalModel(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _itemImage(item),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    item.article.articleTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                _infoText(item)
              ], // 文字从左开始排列
            ),
          ),
        ),
      );
  // 图片部分
  _itemImage(TravelItem item) => Stack(
        children: <Widget>[
          Image.network(item.article.images[0]?.dynamicUrl),
          Positioned(
              bottom: 8,
              left: 8,
              // width: 200,
              child: LimitedBox(
                  maxWidth: 180,
                  child: Opacity(
                    opacity: 0.7,
                    child: RawChip(
                        backgroundColor: Colors.black,
                        avatar: CircleAvatar(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        label: Text(
                          item.article?.pois[0]?.poiName ?? '未知',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        )),
                  )))
        ],
      );
  // 文字部分
  _infoText(TravelItem item) => Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                PhysicalModel(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  child: ClipOval(
                    child: Image.network(
                      item.article.images[0]?.dynamicUrl,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 90,
                  child: Text(
                    item.article.author?.nickName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.thumb_up,
                  size: 14,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(item.article.likeCount.toString()),
                )
              ],
            )
          ],
        ),
      );
  @override
  bool get wantKeepAlive => true; // 缓存页面防止重绘
}
