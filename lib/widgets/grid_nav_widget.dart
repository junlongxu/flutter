import 'package:flutter/material.dart';
import 'package:flutter_tourism/demo/http.dart';
import 'package:flutter_tourism/model/grid_nav_model.dart';
import 'package:flutter_tourism/utils/color_parse.dart';
import 'package:flutter_tourism/utils/navigator_util.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

class GridNavWidget extends StatelessWidget {
  final GridNavModel gridNavModel;
  GridNavWidget({Key key, this.gridNavModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridNavItems(context),
        ),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    if (gridNavModel == null) return null;
    List<Widget> items = [];
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });
    return Container(
        height: 88,
        margin: first ? null : EdgeInsets.only(top: 3),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          ColorParse.parse(gridNavItem?.startColor),
          ColorParse.parse(gridNavItem?.endColor)
        ])),
        child: Row(children: expandItems));
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(children: <Widget>[
          Image.network(
            model.icon,
            fit: BoxFit.contain,
            width: 121,
            height: 88,
            alignment: AlignmentDirectional.bottomCenter,
          ),
          Container(
              margin: EdgeInsets.only(top: 11),
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                model.title,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ))
        ]),
        model);
  }

  _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(children: <Widget>[
      Expanded(child: _item(context, topItem, true)),
      Expanded(child: _item(context, bottomItem, false)),
    ]);
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //撑满父布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          left: borderSide,
          bottom: first ? borderSide : BorderSide.none,
        )),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
        child: widget,
        onTap: () {
          NavigatorUtil.push(
              context,
              WebViewWidget(
                url: model.url,
                title: model.title,
                statusBarColor: model.statusBarColor,
                hideAppBar: model.hideAppBar,
              ));
        });
  }
}
