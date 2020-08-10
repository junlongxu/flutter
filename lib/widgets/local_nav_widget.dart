import 'package:flutter/material.dart';
import 'package:flutter_tourism/model/common_model.dart';
import 'package:flutter_tourism/widgets/web_view_widget.dart';

class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNavWidget({Key key, @required this.localNavList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Padding(padding: EdgeInsets.all(7), child: _items(context)));
  }

  Widget _items(BuildContext context) {
    if(localNavList == null) return null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [...localNavList.map((model) => _item(context, model))],
    );
  }

  Widget _item(BuildContext context,CommonModel model){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
          MaterialPageRoute(builder: (context) => WebViewWidget(
            url: model.url,
            statusBarColor: model.statusBarColor,
            title: model.title,
            hideAppBar: model.hideAppBar,
          ))
        );
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            height: 32,
            width: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12)
          )
        ],
      )
    );
  }
}
