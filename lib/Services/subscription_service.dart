import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kidspace/Services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService {
  Dio dio = Dio();

  getPlans() async {
    SharedPreferences prefs0 = await SharedPreferences.getInstance();
    var prefs = prefs0.getString('authData');
    var jsonDecoded = jsonDecode(prefs!);
    var token = jsonDecoded['token'];
    dio.options.headers['Authorization'] = "Bearer $token";
    var res = await dio.get('${Api().api}subscription-plans');
    var data = res.data;
    if (data['status'] == 200) {
      return data['data'];
    } else {
      return false;
    }
  }

  paymentSuccess(data) async {
    try {
      SharedPreferences prefs0 = await SharedPreferences.getInstance();
      var prefs = prefs0.getString('authData');
      print(prefs);
      var jsonDecoded = jsonDecode(prefs!);
      var token = jsonDecoded['token'];
      dio.options.headers['Authorization'] = "Bearer $token";
      var res = await dio.post('${Api().api}user-subscriptions', data: data);
      var finalData = res.data;
      if (finalData['status'] == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print('mayako sagar: $e');
    }
  }
}
