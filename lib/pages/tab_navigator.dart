import 'package:flutter/material.dart';
import 'package:flutter_tourism/pages/h5_page.dart';
import 'package:flutter_tourism/pages/home_page.dart';
import 'package:flutter_tourism/pages/my_page.dart';
import 'package:flutter_tourism/pages/search_page.dart';
import 'package:flutter_tourism/pages/travel_page.dart';

class TabNavigator extends StatefulWidget{
  int currentIndex;
  TabNavigator({this.currentIndex = 0});
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blue;
  final PageController _controller = PageController(
    initialPage: 1
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(), //禁止滑动
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true),
          TravelPage(),
          MyPage(),
          H5Page()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            widget.currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _defaultColor),
            activeIcon: Icon(Icons.home, color: _activeColor),
            title: Text(
              '首页',
              style: TextStyle(
                color: widget.currentIndex != 0 ? _defaultColor : _activeColor
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _defaultColor),
            activeIcon: Icon(Icons.search, color: _activeColor),
            title: Text(
              '搜索',
              style: TextStyle(
                color: widget.currentIndex != 1 ? _defaultColor : _activeColor
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, color: _defaultColor),
            activeIcon: Icon(Icons.camera_alt, color: _activeColor),
            title: Text(
              '旅拍',
              style: TextStyle(
                color: widget.currentIndex != 2 ? _defaultColor : _activeColor
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor),
            activeIcon: Icon(Icons.account_circle, color: _activeColor),
            title: Text(
              '我的',
              style: TextStyle(
                color: widget.currentIndex != 3 ? _defaultColor : _activeColor
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor),
            activeIcon: Icon(Icons.account_circle, color: _activeColor),
            title: Text(
              'H5',
              style: TextStyle(
                color: widget.currentIndex != 4 ? _defaultColor : _activeColor
              ),
            )
          )
        ]),
    );
  }

  Widget _bottomNavigationBar() {
    
  }
}