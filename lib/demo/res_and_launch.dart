import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ResAndLaunch extends StatefulWidget{
  @override
  _ResAndLaunchState createState() => _ResAndLaunchState();
}

class _ResAndLaunchState extends State<ResAndLaunch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('引用资源和打开第三方应用'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('打开地图'),
              onPressed: () {
                return _openMap();
              },
            ),
            RaisedButton(
              child: Text('打开浏览器'),
              onPressed: () => _launchURL()
            ),
            Image(
              width: 100,
              height: 100,
              image: AssetImage('images/avatar.png')
            )
          ]
        )
      )
    );
  }

  _openMap() async {
    // Android
    const url = 'geo:52.32,4.917'; //APP提供者提供的 schema
    if(await canLaunch(url)) {
      await launch(url);
    } else {
      // ios
      const url = 'http://maps.apple.com/?ll=52.32,4.917';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
  _launchURL() async {
    const url = 'http://baidu.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


