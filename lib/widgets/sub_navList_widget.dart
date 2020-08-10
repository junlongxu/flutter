import 'package:flutter/material.dart';
import 'package:flutter_tourism/model/common_model.dart';

class SubNavListWidget extends StatelessWidget {
  final List<CommonModel> subNavList;
  SubNavListWidget({Key key, this.subNavList}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(7, 0, 7, 0), child: _subNavItem(context));
  }

  Widget _subNavItem(BuildContext context) {
    if (subNavList == null) return null;
    return GridView.count(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(2.0), // 外边距
      children: _gridList(context),
    );
  }

  List<Widget> _gridList(BuildContext context) {
    return subNavList
        .map((item) => Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.amber),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Image.network(
                    item.icon,
                    height: 32,
                    width: 32,
                  ),
                  Text(
                    item.title,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  )
                ],
              ),
            ))
        .toList();
  }
}
