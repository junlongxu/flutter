import 'package:flutter/material.dart';
import 'package:flutter_tourism/pages/home_page.dart';
import 'package:flutter_tourism/pages/my_page.dart';
import 'package:flutter_tourism/pages/community_page.dart';
import 'package:flutter_tourism/pages/task_page.dart';
// import 'package:flutter_svg/flutter_svg.dart';
class TabNavigator extends StatefulWidget {
  int currentIndex;
  TabNavigator({this.currentIndex = 0});
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blue;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(), //禁止滑动
        children: <Widget>[
          HomePage(),
          CommunityPage(),
          TaskPage(),
          MyPage(),
          // SvgPicture.asset()
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
            _bottomNavigationBar(0, Icons.home, '首页'),
            _bottomNavigationBar(1, Icons.search, '任务'),
            _bottomNavigationBar(2, Icons.camera_alt, '旅拍'),
            _bottomNavigationBar(3, Icons.arrow_downward, '我的')
          ]),
    );
  }
//     - assets/home.svg
//     - assets/home_active.svg
//     - assets/community.svg
//     - assets/community_active.svg
//     - assets/camera.svg
//     - assets/task.svg
//     - assets/task_active.svg
//     - assets/my.svg
//     - assets/my_active.svg
  _bottomNavigationBar(int index, IconData icon, String title) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
        title: Text(title,
            style: TextStyle(
                color: widget.currentIndex != index
                    ? _defaultColor
                    : _activeColor)));
  }
}
