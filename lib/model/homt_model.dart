
import 'package:flutter/cupertino.dart';
import 'package:flutter_tourism/model/sales_box_model.dart';

import 'common_model.dart';
import 'config_model.dart';
import 'grid_nav_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;
  // required传参数, = 参数默认值
  HomeModel({this.config = null, this.bannerList, this.localNavList, this.subNavList, @required this.gridNav, this.salesBox});
  factory HomeModel.fromJson(Map<String, dynamic> json){
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((banner) => CommonModel.fromJson(banner)).toList();
    // var bannerListJson1 = json['bannerList'];
    // print(bannerListJson);
    // print(bannerListJson);

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((localnav) => CommonModel.fromJson(localnav)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((subnav) =>  CommonModel.fromJson(subnav)).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList
    );
  }
}