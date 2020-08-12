import 'package:flutter/material.dart';
import 'package:flutter_tourism/api/search_dao.dart';
import 'package:flutter_tourism/model/search_model.dart';
import 'package:flutter_tourism/utils/navigator_util.dart';
import 'package:flutter_tourism/widgets/search_bar.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=长城';
const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchurl;
  final String keyword;
  final String hint;
  const SearchPage(
      {Key key,
      this.hideLeft,
      this.searchurl = SEARCH_URL,
      this.keyword,
      this.hint})
      : super(key: key);
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        _appBar,
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return _item(index);
                  },
                )))
      ],
    ));
  }

  _item(int index) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[index];
    return GestureDetector(
        onTap: () {
          NavigatorUtil.push(
              context, WebViewWidget(url: item.url, title: '详情'));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(1),
                child: Image(
                  height: 26,
                  width: 26,
                  image: AssetImage(_iamge(item.type))
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    child: _title(item),
                  ),
                  Container(
                    width: 300,
                    child: _subTitle(item),
                  )
                ],
              )
            ],
          ),
        ));
  }
  String _iamge(String type){
    if(type == null) return 'images/type_travelgroup.png';
    String defaultPath = 'travelgroup';
    for (final val in TYPES) {
      if(type.contains(val)){
        defaultPath = val;
        break;
      }
    }
    return 'images/type_$defaultPath.png';
  }
  _title(SearchItem item){

  }
  _subTitle(SearchItem item) {

  }
  _onChanged(String text) {
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    // 拼接地址和输入value
    String url = widget.searchurl + text;
    SearchDao(url, text).then((SearchModel model) {
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((err) {
      print(err);
    });
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
              padding: EdgeInsets.only(top: 20),
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: SafeArea(
                child: SearchBar(
                  searchBarType: SearchBarType.normal,
                  hideLeft: widget?.hideLeft,
                  defaultText: widget.keyword,
                  hint: '123',
                  leftButtonClick: () {
                    Navigator.pop(context);
                  },
                  onChanged: _onChanged,
                ),
              )),
        )
      ],
    );
  }
}
