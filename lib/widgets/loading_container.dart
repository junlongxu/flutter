import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.child,
      @required this.isLoading,
      this.cover = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 数据没有返回显示_loadingView, 返回后是flase就展示child
    var lodingOrChild = !isLoading ? child : _loadingView;
    return !cover
        ? lodingOrChild
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : Container()],
          );
  }

  Widget get _loadingView {
    return Center(child: CircularProgressIndicator(
      backgroundColor: Colors.white
    ));
  }
}
