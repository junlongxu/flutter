
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

class LessGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'less_gr111oup_page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('less_grouprrr_page'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                '111',
                style: textStyle
              ),
              Icon(
                Icons.announcement,
                size: 50,
                color: Colors.red,
              ),
              CloseButton(),
              BackButton(),
              // Chip(
              //   avatar: Icon(Icons.people),
              //   // autofocus: true
              // ),
              Divider(
                height: 10,
                indent: 10,
                color: Colors.orange,
                thickness: 1
              ),
              Card(
                color: Colors.red,
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Card',
                    style: textStyle,
                  ),
                ),
              ),
              AlertDialog(
                title: Text('AlertDialog'),
                titlePadding: EdgeInsets.fromLTRB(10, 20, 30, 40),
                content: Text('内容区')
              )
              // Icon()
            ],
          ),
        ),
      ),
    );
  }
}
