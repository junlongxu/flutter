
// 常用StatelessWidget组件 
  // 1. Container 容器组件
  // 2. Text
  // 3. Icon
  // 4. CloseButton
  // 5. BackButton
  // 6. Chip 
  // 7. Divider 分割线组件
  // 8. Card
  // 9. AlertDialog

import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_tourism/demo/AnimatedBottomBar.dart';
import 'package:flutter_tourism/demo/app_lifecycle.dart';
import 'package:flutter_tourism/demo/flutter_widget_lifecycle.dart';
import 'package:flutter_tourism/demo/home.dart';
import 'package:flutter_tourism/demo/less_group_page.dart';
import 'package:flutter_tourism/demo/gesture_page.dart';
import 'package:flutter_tourism/demo/ful_group_page.dart';
import 'package:flutter_tourism/demo/layout.dart';
import 'package:flutter_tourism/demo/photo_app.dart';
import 'package:flutter_tourism/demo/res_and_launch.dart';

void main() {
  runApp(DynamicTheme());
}

class DynamicTheme extends StatefulWidget{
  _DynamicThemeState createState() => _DynamicThemeState();
}
class _DynamicThemeState extends State<DynamicTheme> {
  Brightness _brightness = Brightness.light;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',  
      theme: ThemeData(
        // fontFamily: 'RubikMonoOne', // 修改全局英文字体 因为是下载的字体文件是英文文件
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('路由导航'),
        // ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  if(_brightness == Brightness.dark) {
                    _brightness = Brightness.light;
                  } else {
                    _brightness = Brightness.dark;
                  }
                });
              },
              child: Text('切换主题a', style: TextStyle(fontFamily: 'RubikMonoOne'),),
            ),
            RouteNabigator()
          ]
        )
      ),
      routes: <String, WidgetBuilder>{
        'ful': (BuildContext context) =>  StateFullGroup(),
        'less': (BuildContext context) => LessGroupPage(),
        'layout': (BuildContext context) => StateFullLayout(),
        'gesture': (BuildContext context) => GesturePage(),
        'launch': (BuildContext context) => ResAndLaunch(),
        'widget': (BuildContext context) => WidgetLifecycle(),
        'app': (BuildContext centext) => AppLifecycle(),
        'phone': (BuildContext centext) => PhoneApp(),
        'animated': (BuildContext centext) => AnimatedBottomBar(),
        'home': (BuildContext centext) => WallHomePage(),
      }
    );
  }
}

class RouteNabigator extends StatefulWidget {
  @override
  _RouteNabigatorState createState() => _RouteNabigatorState();
}

class _RouteNabigatorState extends State<RouteNabigator> {
  bool byName = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名跳转'),
            value: byName, 
            onChanged: (value) {
              setState(() {
                byName  = value;
              });
            }
          ),
          _item('动态组件a', StateFullGroup(), 'ful'),
          _item('静态组件a', LessGroupPage(), 'less'),
          _item('布局a', StateFullLayout(), 'layout'),
          _item('手势a', GesturePage(), 'gesture'),
          _item('使用静态资源和打开第三方应用a', ResAndLaunch(), 'launch'),
          _item('页面生命周期a', WidgetLifecycle(), 'widget'),
          _item('app声明周期a', AppLifecycle(), 'app'),
          _item('拍照', PhoneApp(), 'phone'),
          _item('animat', AnimatedBottomBar(), 'animated'),
          _item('home', WallHomePage(), 'home'),
        ]
      )
    );
  }

  _item(String title, page, String routeName){
    return Container(
      child: RaisedButton(
        child: Text(title),
        onPressed: () {
          if(byName) { 
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => page)
            );
          }
        },
      ),
    );
  }
}
