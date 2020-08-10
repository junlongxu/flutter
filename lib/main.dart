
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
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_tourism/pages/tab_navigator.dart';


void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness:Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // SystemUiOverlayStyle systemUiOverlayStyle =
  //   SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: TabNavigator()
    );
  }
}
