import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:kidspace/Screens/AccountsScreen/account.dart';
import 'package:kidspace/Screens/Subscription_screen/subscription_screen.dart';
import 'package:kidspace/Services/shared_prefs.dart';
import 'api.dart';

class AuthService {
  final Dio dio = Dio();
  final SharedPrefs shared = SharedPrefs();

  //Login
  Future<bool> login(
      BuildContext context, String email, String password) async {
    final url = '${Api().api}login';

    try {
      final response =
          await dio.post(url, data: {'email': email, 'password': password});
      print(response.data);

      if (response.statusCode == 200) {
        final data = {
          'user': response.data['user'],
          'token': response.data['token'],
        };

        final prefs = await shared.getPrefs();
        await prefs.setString('authData', jsonEncode(data));

        final isSubscribed = response.data['isSubscribe'] ?? false;

        if (isSubscribed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Account()),
          );
        } else {
          print('Go into Subscription page');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SubscriptionPage()),
          );
        }
      } else {
        showSnackbar(context, 'Login invalid');
      }
      return true;
    } catch (error) {
      print('Error occurred: $error');
      showSnackbar(context, 'Please enter valid credentials!!');
      return false;
    }
  }

  //Register
  registerUserInfo(context, fullname, email, password, confirmPassword) async {
    try {
      var jsonData = jsonEncode({
        'name': fullname,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword
      });

      var response = await dio.post('${Api().api}register', data: jsonData);
      print(response);

      // Handle the response here
      if (response.data['status'] == 402) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Email Already Exists',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 74, 64, 255),
        ));
      }

      if (response.data['status'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Registeration Successful',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 74, 64, 255),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SubscriptionPage()),
        );
      } 
      if (response.data['status'] == 400) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Enter Valid Email Address',
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 74, 64, 255),
          ));
        }
      else {
        print('User registration failed');
      }
    } catch (error) {
      print('Error occurred during registration: $error');
    }
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  checkUserToken(token) async {
    try {
      dio.options.headers['Authorization'] = "Bearer $token";
      dio.options.headers['Accept'] = "application/json";
      var res = await dio.get("${Api().api}check-user");
      var data = res.data;
      if (data['status'] == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (_) {
      return false;
    }
  }
}
