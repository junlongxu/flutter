import 'package:flutter/material.dart';
import 'package:flutter_tourism/api/travel_tab_dao.dart';
import 'package:flutter_tourism/model/travel_tab_mode.dart';
import 'package:flutter_tourism/pages/travel_waterfall_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List<Tabs> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this); //fix tab label 空白问题
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 40),
              child: TabBar(
                controller: _controller,
                isScrollable: true, // 可以左右滑动
                labelColor: Colors.black, // 显示颜色
                labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: UnderlineTabIndicator(
                    // 显示文字active
                    borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                    insets: EdgeInsets.only(bottom: 4)),
                tabs: tabs.map<Tab>((tab) => Tab(text: tab.labelName)).toList(),
              ),
            ),
            Flexible(
              flex: 1,
              child: TabBarView(
                controller: _controller,
                // Text规定返回的类型
                children: tabs
                    .map<Widget>((tab) => TravelWaterfallPage(travelUrl: travelTabModel.url,groupChannelCode: tab.groupChannelCode))
                    .toList(),
              ),
            )
          ],
        ),
      );
}
