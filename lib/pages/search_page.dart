import 'package:flutter/material.dart';
import 'package:flutter_tourism/api/search_dao.dart';
import 'package:flutter_tourism/model/search_model.dart';
import 'package:flutter_tourism/utils/navigator_util.dart';
import 'package:flutter_tourism/widgets/search_bar.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';
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
  void initState() {
    if (widget.keyword != null) {
      _onChanged(widget.keyword);
    }
    super.initState();
  }

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
                  // 会把所有元素进行遍历
                  itemBuilder: (BuildContext context, int index) {
                    return _item(searchModel.data[index]);
                  },
                )))
      ],
    ));
  }

  _item(SearchItem item) {
    if (searchModel == null || searchModel.data == null || item == null) return null;
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
                    image: AssetImage(_iamge(item.type))),
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

  // 左侧icon图片
  String _iamge(String type) {
    if (type == null) return 'images/type_travelgroup.png';
    String defaultPath = 'travelgroup';
    for (final val in TYPES) {
      if (type.contains(val)) {
        defaultPath = val;
        break;
      }
    }
    return 'images/type_$defaultPath.png';
  }

  // 上半部分文字
  _title(SearchItem item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
    spans.add(TextSpan(
        text: ' ${(item.districtname ?? '')}  ${item.zonename ?? ''}',
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: item.price ?? '',
            style: TextStyle(fontSize: 16, color: Colors.orange)),
        TextSpan(
            text: '  ${item.star ?? ''}',
            style: TextStyle(fontSize: 12, color: Colors.grey))
      ]),
    );
  }

  // 给keyword设置高亮
  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    int i = 0;
    while (i < arr.length) {
      //'wordwoc'.split('w') -> [, ord, oc] @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: normalStyle));
      }
      if (arr[i] != null && arr[i].length != 0) {
        spans.add(TextSpan(text: arr[i], style: keywordStyle));
      }
    }
    return spans;
  }

  _onChanged(String text) {
    keyword = text;
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
