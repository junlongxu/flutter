import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebViewWidget extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;
  final bool bottomAppBar;

  WebViewWidget(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar = false,
      this.backForbid = false,
      this.bottomAppBar = false}) {
    if (url != null && url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      url = url.replaceAll("http://", 'https://');
    }
  }
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  // 在Webview中监听滚动事件FlutterWebviewPlugin
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrkChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;
  @override
  void initState() {
    // 初始化监听
    webviewReference.dispose();
    // FlutterWebviewPlugin 提供链接到一个唯一Web视图的单例实例，因此您可以从应用程序中的任何位置控制Web视图
    _onUrkChanged = webviewReference.onUrlChanged.listen((String url) {});
    // 将自定义代码注入Web视图
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.finishLoad) {
        // 如果不包含白名单内的url
        if (_isToMain(state.url) && !exiting) {
          // 是true禁止返回
          if (widget.backForbid) {
            // 重新加载当前页面
            webviewReference.launch(widget.url);
          } else {
            Navigator.pop(context);
            exiting = true;
          }
        }
      }
    });
    // 监听错误
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
    super.initState();
  }

  @override
  void dispose() {
    _onUrkChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  bool _isToMain(String url) {
    bool contain = false;
    int i = 0;
    while (i < CATCH_URLS.length) {
      if (url?.contains(CATCH_URLS[i]) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  // 跳转的组装页面
  @override
  Widget build(BuildContext context) {
    final String str = 'ffffff';
    String statusBarColorStr = widget.statusBarColor ?? str;
    Color backButtonColor;
    if (statusBarColorStr == str) {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
              child: WebviewScaffold(
                  userAgent: 'null',
                  url: widget.url,
                  withZoom: true,
                  withLocalStorage: true,
                  hidden: true,
                  initialChild: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('Waiting...'),
                    ),
                  ),
                  // bottomNavigationBar: TabNavigator(currentIndex: 4)
            ))
        ],
      ),
    );
  }

  // 跳转页面的顶部栏
  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 0,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.close, color: backButtonColor, size: 26),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Center(
                    child: Text(widget.title ?? '',
                        style:
                            TextStyle(color: backButtonColor, fontSize: 20)))),
          ],
        ),
      ),
    );
  }
}
