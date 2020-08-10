import 'package:flutter/material.dart';
import 'package:flutter_tourism/api/home_dao.dart';
import 'package:flutter_tourism/model/common_model.dart';
import 'package:flutter_tourism/model/grid_nav_model.dart';
import 'package:flutter_tourism/model/homt_model.dart';
import 'package:flutter_tourism/widgets/grid_nav_widget.dart';
import 'package:flutter_tourism/widgets/local_nav_widget.dart';
import 'package:flutter_tourism/widgets/sub_navList_widget.dart';
import 'package:flutter_tourism/widgets/swiper_widget.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';


const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<HomePage> {

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  @override
  void initState() {
    _handleRefresh();
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
    super.initState();
  }
  Future<Null> _handleRefresh() async{
    try{
      HomeModel model = await HomeDao();
      bannerList = model.bannerList;
      localNavList = model.localNavList;
      subNavList = model.subNavList;
      gridNavModel = model.gridNav;
    }catch(e) {
      print('-------->$e');
    }
  }

  double appBarAlpha = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: ListView(
                  children: <Widget>[
                    SwiperWidget(bannerList: bannerList),
                    LocalNavWidget(localNavList: localNavList),
                    GridNavWidget(gridNavModel: gridNavModel),
                    // 活动入口
                    SubNavListWidget(subNavList: subNavList),
                    // Container(
                    //   height: 800,
                    //   child: ListTile(
                    //     title: Text('哈哈啊'),
                    //   ),
                    // )
                  ],
                ),
              )),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('首页'),
              )),
            ),
          )
        ],
      ),
    );
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
}
