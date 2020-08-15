import 'package:flutter/material.dart';
// import 'package:flutter_tourism/widgets/web_view_widget.dart';

class CommunityPage extends StatefulWidget{
  _CommunityPageState createState() => _CommunityPageState();
}
class _CommunityPageState extends State<CommunityPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('社区'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
