import 'package:flutter_tourism/model/homt_model.dart';
import 'package:flutter_tourism/utils/http.dart';

// ignore: missing_return
// ignore: non_constant_identifier_names
Future<HomeModel> HomeDao() async {
  var result = await HttpRes.request(
    url: 'home_page.json',
    method: 'get',
    json: {},
  );
  return HomeModel.fromJson(result);
}
