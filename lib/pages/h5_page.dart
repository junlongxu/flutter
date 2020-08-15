import 'package:flutter/material.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

class H5Page extends StatefulWidget {
  _H5PagePageState createState() => _H5PagePageState();
}

class _H5PagePageState extends State<H5Page> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WebViewWidget(
          url:
              'http://172.24.135.208/taskpage/#/task?token=5bdfd06de5d264efe5528399b436f9e2',
          statusBarColor: 'ffffff',
          title: 'H5',
          hideAppBar: true,
          bottomAppBar: true),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
