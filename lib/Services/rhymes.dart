import "dart:convert";
import "package:dio/dio.dart";
import "package:kidspace/Services/api.dart";
import "package:kidspace/Services/shared_prefs.dart";
import "package:shared_preferences/shared_preferences.dart";

class RhymesServices {
  Dio dio = Dio();
  
  Future<String?> getTokenFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authData = prefs.getString('authData');

    if (authData != null) {
      Map<String, dynamic> jsonData = jsonDecode(authData);
      String? token = jsonData['token'];
      return token;
    }
    return null;
  }

  getRhymes() async {
    try {
      String? token = await getTokenFromSharedPrefs();
      dio.options.headers['Authorization'] = "Bearer $token";
      var res = await dio.get('${Api().api}get-rhymes');
      var data = res.data;
      if (data['status'] == 200) {
        return data['data'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  getRecentPlayed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await SharedPrefData().getTokenFromSharedPrefs();
    int? accountId = prefs.getInt('accountId');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print("THe account issssss $accountId");

    final response = await dio.get("${Api().api}recent-rhymes/$accountId",
        options: Options(headers: headers));
    var data = response.data;
    return data['data'];
  }

  getPoint(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? position = prefs.getString('videoPlaybacks$id');
    Duration currentPlaybackPosition;
    if (position != null) {
      List<String> durationParts = position.split(':');
      int hours = int.parse(durationParts[0]);
      int minutes = int.parse(durationParts[1]);
      List<String> secondsAndMilliseconds = durationParts[2].split('.');
      int seconds = int.parse(secondsAndMilliseconds[0]);
      int milliseconds = int.parse(secondsAndMilliseconds[1]);

      currentPlaybackPosition = Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
      );
      return currentPlaybackPosition;
    } else {
      Duration.zero;
    }
  }
}
