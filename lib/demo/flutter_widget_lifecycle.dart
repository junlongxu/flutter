import 'package:flutter/material.dart';

class WidgetLifecycle extends StatefulWidget{
  @override
  _WidgetLifecycleState createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {
  int _count = 0;


  @override
  void initState() {
    print('-----initState----');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('----didChangeDependencies更新期间');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('声明周期'),
          leading: BackButton()
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  setState(() {
                    _count += 1;
                  });
                },
                child: Text(
                  '点我',
                  style: TextStyle(fontSize:  26)
                ),
              ),
              Text(_count.toString())
            ],
          ),
        )
      ),
    );
  }

  @override
  void didUpdateWidget (WidgetLifecycle oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate移除时调用');
    super.deactivate();
  }

  @override
  void dispose() {
    print('--dispose常用销毁时调用');
    super.dispose();
  }
}