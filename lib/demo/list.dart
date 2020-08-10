import 'package:flutter/material.dart';

class ListLayout extends StatefulWidget {
  @override
  _ListLayoutState createState() => _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  // ignore: non_constant_identifier_names
  List<String> CITYS = ['北京', '上海', '广州', '深证', '郑州', '南京', '合肥', '包头', '重庆'];
  // ignore: non_constant_identifier_names
  Map<String, List<String>> CITYSMAP = {
    '1': ['北京', '深证', '郑州', '南京', '合肥', '包头', '重庆'],
    '2': ['上海', '深证', '郑州', '南京', '合肥', '包头', '重庆'],
    '3': ['广州', '深证', '郑州', '南京', '合肥', '包头', '重庆']
  };
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
                title: Text('列表'),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.add_alarm), text: 'ListView的xy滚动'),
                  Tab(icon: Icon(Icons.add_alert), text: 'ExpansionbTile展开列表'),
                  Tab(icon: Icon(Icons.add_box), text: 'GridView网格布局'),
                  Tab(icon: Icon(Icons.add_call), text: '上拉刷新'),
                  Tab(icon: Icon(Icons.add_call), text: '下拉加载')
                ])),
            body: TabBarView(children: [
              Center(child: _listXY()),
              Center(child: _ExpansionList()),
              Center(child: _GirdView()),
              Center(child: _RefreshDown()),
              Center(child: _RefreshUp())
            ])));
  }

  // ListView的xy滚动
  Widget _listXY() {
    return MaterialApp(
        title: 'ListView的xy滚动',
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView的xy滚动'),
            ),
            body: Container(
              // height: 200, // X轴滚动
              child: ListView(
                // scrollDirection: Axis.horizontal, // X轴滚动
                children: _listXYBuild(),
              ),
            )));
  }

  List<Widget> _listXYBuild() {
    return CITYS
        .map((String city) => Container(
              // width: 60, // X轴设置
              // margin: EdgeInsets.only(right: 5), // X轴设置
              height: 60,
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Text(city,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ))
        .toList();
  }

  // ExpansionbTile展开列表
  Widget _ExpansionList() {
    return MaterialApp(
      title: 'ExpansionbTile展开列表',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ExpansionbTile展开列表'),
        ),
        body: Container(
          child: ListView(
            children: _ExpansionListBuild(),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  List<Widget> _ExpansionListBuild() {
    return CITYSMAP.keys
        .map((key) => ExpansionTile(
              title: Text(key),
              children: CITYSMAP[key]
                  .map((city) => FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(bottom: 5, left: 20),
                          decoration: BoxDecoration(color: Colors.greenAccent),
                          child: Text(city),
                        ),
                      ))
                  .toList(),
            ))
        .toList();
  }

  // GridView网格布局
  // ignore: non_constant_identifier_names
  Widget _GirdView() {
    return MaterialApp(
      title: '网格布局',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grid网格布局'),
        ),
        body: GridView.count(
          // childAspectRatio: 1.0,
          // shrinkWrap:true,
          mainAxisSpacing: 2.0, // 下方
          crossAxisSpacing: 2.0, //中间
          padding: const EdgeInsets.all(2.0), // 外边距
          crossAxisCount: 2,
          children: _GirdViewList(),
        ),
      ),
    );
  }

  // ignore: missing_return
  List<Widget> _GirdViewList() {
    return CITYS
        .map((city) => Container(
              height: 80,
              // margin: EdgeInsets.only(bottom: 5, left: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                city,
              ),
            ))
        .toList();
  }

  // 下拉刷新
  // ignore: non_constant_identifier_names
  Widget _RefreshDown() {
    return MaterialApp(
      title: '下拉刷新',
      home: Scaffold(
        appBar: AppBar(
          title: Text('下拉刷新'),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          backgroundColor: Colors.black54,
          displacement: 20,
          child: ListView(

            children: _RefreshDownList(),
          ),
        ),
      ),
    );
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      CITYS = CITYS.reversed.toList(); // 翻转数组
    });
    return null;
  }

  // ignore: non_constant_identifier_names
  List<Widget> _RefreshDownList() {
    return CITYS
        .map((city) => Container(
              height: 60,
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Text(city),
            ))
        .toList();
  }

  // 上拉加载
  // ignore: non_constant_identifier_names
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
            _AddList();
          }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _RefreshUp() {
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            controller: _scrollController,
            children: _RefreshUpList(), // 和下拉刷新逻辑一样
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      CITYS = CITYS.reversed.toList();
    });
    return null;
  }
  _AddList() async {
    await Future.delayed(Duration(microseconds: 200));
    setState(() {
      List<String> list = List<String>.from(CITYS);
      list.addAll(CITYS);
      CITYS = list;
    });
  }
   // ignore: non_constant_identifier_names
  List<Widget> _RefreshUpList() {
    return CITYS
        .map((city) => Container(
              height: 60,
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Text(city),
            ))
        .toList();
  }
}
