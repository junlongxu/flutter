import 'package:flutter_tourism/demo/http.dart';

class SalesBoxModel {
  final String icon;
  final String moreUrl;
  final CommonModel bigCard1;

  SalesBoxModel({this.icon, this.moreUrl, this.bigCard1});

  factory SalesBoxModel.formJson(Map<String, dynamic> json) {
    return SalesBoxModel(
      icon: json['icon'],
      moreUrl: json['moreUrl'],
      bigCard1: CommonModel.formJson(json['bigCard1'])
    );
  }
}