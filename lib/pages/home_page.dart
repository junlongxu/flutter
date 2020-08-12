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
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';
class HomePage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    _handleRefresh();
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
    super.initState();
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao();
      bannerList = model.bannerList;
      localNavList = model.localNavList;
      subNavList = model.subNavList;
      gridNavModel = model.gridNav;
      salesBoxModel = model.salesBox;
      _loading = false;
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('-------->$e');
    }
    return null;
  }

  double appBarAlpha = 0;
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
        SwiperWidget(bannerList: bannerList),
        LocalNavWidget(localNavList: localNavList),
        GridNavWidget(gridNavModel: gridNavModel),
        // 活动入口
        SubNavWidget(subNavList: subNavList),
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
              end: Alignment.bottomCenter
            )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: ()=>{},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }
  _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage(
      hint: SEARCH_BAR_DEFAULT_TEXT,
      hideLeft: false
    ));
  }
  _jumpToSpeak() {

  }
}
