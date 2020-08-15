import 'package:flutter/material.dart';
import 'package:flutter_tourism/api/home_dao.dart';
import 'package:flutter_tourism/model/common_model.dart';
import 'package:flutter_tourism/model/grid_nav_model.dart';
import 'package:flutter_tourism/model/homt_model.dart';
import 'package:flutter_tourism/model/sales_box_model.dart';
import 'package:flutter_tourism/pages/search_page.dart';
import 'package:flutter_tourism/utils/navigator_util.dart';
import 'package:flutter_tourism/widgets/grid_nav_widget.dart';
import 'package:flutter_tourism/widgets/loading_container.dart';
import 'package:flutter_tourism/widgets/local_nav_widget.dart';
import 'package:flutter_tourism/widgets/search_bar.dart';
import 'package:flutter_tourism/widgets/sub_navList_widget.dart';
import 'package:flutter_tourism/widgets/swiper_widget.dart';
import 'package:flutter_tourism/widgets/sales_box.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  double appBarAlpha = 0;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('-------->$e');
    }
    return null;
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: NotificationListener(
                        // ignore: missing_return
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                        },
                        child: _listView),
                  )),
              _appBar
            ],
          ),
        ));
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        // 轮播图
        SwiperWidget(bannerList: bannerList),

        LocalNavWidget(localNavList: localNavList), 
        // 复杂表格
        GridNavWidget(gridNavModel: gridNavModel),
        // 活动入口
        SubNavWidget(subNavList: subNavList),
        // 底部热门活动
        SalesBox(salesBoxModel: salesBoxModel),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () => {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  _jumpToSearch() {
    NavigatorUtil.push(
        context, SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT, hideLeft: false));
  }

  _jumpToSpeak() {}

  @override
  bool get wantKeepAlive => true;
}
