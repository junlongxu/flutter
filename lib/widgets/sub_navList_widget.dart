import 'package:flutter/material.dart';
import 'package:flutter_tourism/model/common_model.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

class SubNavWidget extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNavWidget({Key key, @required this.subNavList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(7, 3, 7, 0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Padding(padding: EdgeInsets.all(7), child: _items(context))),
    );
  }

  Widget _items(BuildContext context) {
    if (subNavList == null) return null;
    num splitLine = (subNavList.length / 2).floor();
    List<CommonModel> one = subNavList.sublist(0, splitLine);
    List<CommonModel> tow = subNavList.sublist(splitLine, subNavList.length);
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [...one.map((model) => _item(context, model))],
            )),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...tow.map((model) => _item(context, model))],
          ),
        )
      ],
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [...subNavList.map((model) => _item(context, model))],
    // );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewWidget(
                          url: model.url,
                          statusBarColor: model.statusBarColor,
                          title: model.title,
                          hideAppBar: model.hideAppBar,
                        )));
          },
          child: Column(
            children: <Widget>[
              Image.network(
                model.icon,
                height: 18,
                width: 18,
              ),
              Text(model.title, style: TextStyle(fontSize: 12))
            ],
          )),
    );
  }
}
