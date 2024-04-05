import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Services/shared_prefs.dart';

class AuthController {
  final url = "${Api().api}google/auth";
  Dio dio = Dio();
  var shared = SharedPrefs();

  Future loginWithGooogle(token) async {
    bool response;

    try {
      var res = await dio.post(url, data: {'access_token': token});
      var status = res.data['status'];

      if (status == 200) {
        var authData = {
          'user': res.data['user'],
          'token': res.data['token']['token'],
          'isSubscribe': res.data['isSubscribe'],
          'type': 'google'
        };

        var prefs = await shared.getPrefs();
        await prefs.setString('authData', jsonEncode(authData));
        response = true;
      } else {
        response = false;
      }
    } on DioError catch (_) {
      response = false;
    }
    return response;
  }
}
