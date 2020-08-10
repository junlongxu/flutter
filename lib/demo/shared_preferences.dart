import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared extends StatefulWidget {
  @override
  _SharedState createState() => _SharedState();
}

class _SharedState extends State<Shared> {
  String countString = '';
  String localCount = '';
  // 不生效
  // void initState() async{
  //   super.initState();
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove('counter');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('本地存储'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                onPressed: _incrementCounter, child: Text('_incrementCounter')),
            RaisedButton(onPressed: _getCounter, child: Text('_getCounter')),
            RaisedButton(onPressed: _removeCounter, child: Text('清除')),
            Text(
              countString,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              localCount,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    ));
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countString = countString + '1';
    });
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt('counter').toString();
    });
  }
  _removeCounter() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('counter');
  }
}
