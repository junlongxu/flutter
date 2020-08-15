import 'package:flutter/material.dart';
// import 'package:flutter_tourism/widgets/web_view_widget.dart';

class TaskPage extends StatefulWidget{
  _TaskPageState createState() => _TaskPageState();
}
class _TaskPageState extends State<TaskPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('TaskPage'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
