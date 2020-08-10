import 'package:flutter/material.dart';

class AppLifecycle extends StatefulWidget {
  _AppLifecycleState createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('app应用声明周期'),
          leading: BackButton()
        ),
        body: Center(
          child: Text('声明周期'),
        ),
      ),
    );
  }
  // 切换前后台的生命周期
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state=$state');
    if(state == AppLifecycleState.paused) {
      print('app进入后台');
    } else if(state == AppLifecycleState.resumed) {
      print('app进入前台');
    } else if(state == AppLifecycleState.inactive) {
      //不常用：应用程序处于非活动状态，并且未接收用户输入时调用，比如：来了个电话
    } else if(state == AppLifecycleState.detached) {
      // 不常用: 应用程序被挂起是调用, 它不会再ios上触发
    }
  }

  @override
  void dispose() { 
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}