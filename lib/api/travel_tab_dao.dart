import 'dart:async';
import 'dart:convert';

import 'package:flutter_tourism/model/travel_tab_mode.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> Data = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": 1,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {
    "cid": "09031072412827979807",
    "ctok": "",
    "cver": "1.0",
    "lang": "01",
    "sid": "8888",
    "syscode": "09",
    "auth": null,
    "extension": [
      {"name": "tecode", "value": "h5"},
      {"name": "protocal", "value": "https"}
    ]
  },
  "contentType": "json"
};
Future<TravelTabModel> TravelTabDao() async {

  final response = await http.get('http://www.devio.org/io/flutter_app/json/travel_page.json');

  Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
  var result = json.decode(utf8decoder.convert(response.bodyBytes));
  TravelTabModel model = TravelTabModel.fromJson(result);
  return model;
}
