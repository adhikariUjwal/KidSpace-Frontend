import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  getPrefs() async {
    final SharedPreferences prefs = await _prefs;
    return prefs;
  }
}

class SharedPrefData {

  
  //Get User Token
  Future<String?> getTokenFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authData = prefs.getString('authData');
    if (authData != null) {
      Map<String, dynamic> jsonData = jsonDecode(authData);
      print(jsonData);
      String? token = jsonData['token'];
      int userId = jsonData['user']['id'];
      prefs.setInt('userId', userId);
      String userName = jsonData['user']['name'];
      prefs.setString('userName', userName);
      String email = jsonData['user']['email'];
      prefs.setString('email', email);
      String? userimge = jsonData['user']['img'];
      prefs.setString('userimge', userimge ?? 'no img');
      return token;
    }
    return null;
  }

// Get User Token
  Future<String?> getUserIdFromSharedPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authData = prefs.getString('authData');

      if (authData != null) {
        Map<String, dynamic> jsonData = jsonDecode(authData);
        String? userId = jsonData['user']['id'];

        // Check if 'id' field exists and is a non-empty string
        if (userId is String && userId.isNotEmpty) {
          return userId;
        }
      }

      return null;
    } catch (e) {
      // Handle any potential exceptions here (e.g., parsing error)
      print('Error while getting user ID from SharedPreferences: $e');
      return null;
    }
  }
}
