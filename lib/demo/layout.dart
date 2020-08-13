// 常用StatefulWidget组件
// 1. MaterialApp
// 2. Scaffold
// 3. AppBar
// 4. BottomNavigationBar
// 5. RefreshIndicator
// 6. Image
// 7. TextField
// 8. PageView

import 'package:flutter/material.dart';

class StateFullLayout extends StatefulWidget {
  @override
  _StateFullLayoutState createState() => _StateFullLayoutState();
}

class _StateFullLayoutState extends State<StateFullLayout> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
        title: 'layout',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('layout1'),
            backgroundColor: Colors.red,
            toolbarOpacity: 0.5,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.grey),
                  activeIcon: Icon(Icons.home, color: Colors.blue),
                  title: Text('home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list, color: Colors.grey),
                  activeIcon: Icon(Icons.list, color: Colors.blue),
                  title: Text('list')),
            ],
          ),
          floatingActionButton:
              FloatingActionButton(onPressed: null, child: Text('点我')),
          body: _currentIndex == 0
              ? RefreshIndicator(
                  child: ListView(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipOval(
                                child: Image.network(
                                    'http://www.devio.org/img/avatar.png'
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Opacity(
                                    opacity: 0.6,
                                    child: Image.network('http://www.devio.org/img/avatar.png'),
                                  )
                                ),
                              )
                            ],
                          ),
                          Image.network(
                            'http://www.devio.org/img/avatar.png',
                            width: 100,
                            height: 100,
                          ),
                          TextField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  hintText: '请输入',
                                  hintStyle: TextStyle(fontSize: 15))),
                          Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            decoration:
                                BoxDecoration(color: Colors.lightBlueAccent),
                            child: PageView(
                              children: <Widget>[
                                _item('page1', Colors.red),
                                _item('page2', Colors.blue),
                                _item('page3', Colors.blueAccent)
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget> [
                              FractionallySizedBox(
                                widthFactor: 1,
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.red),
                                  child: Text('宽度盛满'),
                                )
                              )
                            ]
                          ),
                        ],
                      ),
                    ),
                    Stack(children: <Widget>[
                      Image.network('http://www.devio.org/img/avatar.png'),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Image.network(
                          'http://www.devio.org/img/avatar.png',
                          width: 36,
                          height: 36,
                        )
                      )
                    ]),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: <Widget>[
                        _chip('flutter'),
                        _chip('flutter1'),
                        _chip('flutter2'),
                        _chip('flutter3')
                      ],
                    )
                  ]),
                  onRefresh: _handleRefresh, // 发生下拉的时候调用
                )
              : Text('list'),
        ));
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(title, style: TextStyle(fontSize: 22, color: Colors.white)),
    );
  }

  _chip(String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Colors.red,
        child: Text(
          label.substring(0, 1),
          style: TextStyle(fontSize: 10)
        ),
      ),
    );
  }
}
