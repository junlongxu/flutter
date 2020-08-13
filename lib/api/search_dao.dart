import 'dart:async';
import 'dart:convert';

import 'package:flutter_tourism/model/search_model.dart';

import 'package:http/http.dart' as http;

Future<SearchModel> SearchDao(String url, String text) async {
  final response = await http.get(url);
  Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
  var result = json.decode(utf8decoder.convert(response.bodyBytes));
  SearchModel model = SearchModel.fromJson(result);
  model.keyword = text;
  return model;
}
