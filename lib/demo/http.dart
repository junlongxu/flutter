import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const URL = 'http://www.devio.org/io/flutter_app/json/test_common_model.json';

class Http extends StatefulWidget {
  @override
  _HttpState createState() => _HttpState();
}

class _HttpState extends State<Http> {
  String showResult = '';
  Future<CommonModel> fetchGet() async {
    final res = await http.get(URL);
    Utf8Decoder utf8decoder = Utf8Decoder(); // 防止乱码
    final result = json.decode(utf8decoder.convert(res.bodyBytes));
    // print('---->$result');
    return CommonModel.fromJson(result);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http1'),
      ),
      body: FutureBuilder<CommonModel>(
        future: fetchGet(),
        builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Input a URL to start');
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.active:
              return new Text('');
            case ConnectionState.done:
              // 错误处理
              if(snapshot.hasError){
                return new Text(
                  'ConnectionState.done  ---hasError',
                  style: TextStyle(color: Colors.red)
                );
              } else {
                return new Column(children: <Widget>[
                  Text('icon: ${snapshot.data.icon}'),
                  Text('statusBarColor: ${snapshot.data.statusBarColor}'),
                  Text('title: ${snapshot.data.title}'),
                  Text('url: ${snapshot.data.url}')
                ],);
              }
          }
        },
      )
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});
  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
