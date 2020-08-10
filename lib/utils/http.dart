import 'package:http/http.dart' as http;
import 'dart:convert';

const BASE_URL = 'http://www.devio.org/io/flutter_app/json/';

class HttpRes {
  static Future request({String url, String method, Map<String, dynamic> json}) async {
    var response;
    final String intactUrl = '$BASE_URL$url';
    switch (method) {
      case 'get':
        response = await http.get(intactUrl, headers: {});
        break;
      case 'post':
        response = await http.post(intactUrl, body: json, headers: {}) as Future;
        break;
      default:
        response = await http.post(intactUrl, body: json, headers: {}) as Future;
    }
    if (response.statusCode != 200) {
      return '';
    } else {
      Utf8Decoder utf8decoder = Utf8Decoder();
      return jsonDecode(utf8decoder.convert(response.bodyBytes));
    }
  }
}

// Future SwitchMethod(String method){
//   switch (method) {
//     case 'post':
//       return
//       break;
//     default:
//   }
// }
