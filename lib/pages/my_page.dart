import 'package:flutter/material.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

class MyPage extends StatefulWidget{
  _MyPageState createState() => _MyPageState();
}
class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebViewWidget(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      )
    );
  }
}
