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
import 'package:flutter_tourism/pages/tab_navigator.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark);
  // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // SystemUiOverlayStyle systemUiOverlayStyle =
  //   SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark);
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter 之旅',
        theme: ThemeData(primarySwatch: Colors.red),
        home: Container(
          decoration: BoxDecoration(color: Colors.white),
          // padding: EdgeInsets.only(top: 2),
          child: TabNavigator(),
        ));
  }
}

// 避开系统区域
class Media extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: TabNavigator(),
    );
  }
}
