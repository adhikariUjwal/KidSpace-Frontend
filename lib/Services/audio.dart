import "dart:convert";

import "package:http/http.dart" as http;
import "package:kidspace/Services/api.dart";
import "package:kidspace/Services/shared_prefs.dart";

class AudioService {
  var apiURL = Api().api;
  SharedPrefData sharedPrefData = SharedPrefData();


  getAudioStory() async {
    String? token = await sharedPrefData.getTokenFromSharedPrefs();

    try {
      var url = Uri.parse('${apiURL}get-audio');
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var data = jsonDecode(response.body);
      return data['data'];
    } catch (e) {
      print("error in audio story $e");
      return [];
    }
  }
}
