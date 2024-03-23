import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Services/shared_prefs.dart';


class AuthController {
  final url = Api().api;
  Dio dio = Dio();
  var shared = SharedPrefs();

  Future loginWithGooogle(token) async {
    print('The googlefirebase send token $token');
    bool response;
    try {
      print('Inside Try');
      var res = await dio.get('${Api().api}auth/google/callback', data: token);
      print(res);
      var data = res.data['status'];
      print("The response data is${res.data}");

      if (data == 200) {
        var authData = {
          'user': res.data['user'],
          'token': res.data['token']['token'],
          'type': 'google'
        };
        var prefs = await shared.getPrefs();
        await prefs.setString('authData', jsonEncode(authData));
        response = true;
      }
      else {
        response = false;
      }
    } on DioException catch (_) {
      response = false;
    }
    return response;
  }
}
