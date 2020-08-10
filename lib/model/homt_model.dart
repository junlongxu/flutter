
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
  factory HomeModel.formJson(Map<String, dynamic> json){
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((banner) => CommonModel.formJson(banner)).toList();
    // var bannerListJson1 = json['bannerList'];
    // print(bannerListJson);
    // print(bannerListJson);

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((localnav) => CommonModel.formJson(localnav)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((subnav) =>  CommonModel.formJson(subnav)).toList();

    return HomeModel(
      config: ConfigModel.formJson(json['config']),
      salesBox: SalesBoxModel.formJson(json['salesBox']),
      gridNav: GridNavModel.formJson(json['gridNav']),
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList
    );
  }
}