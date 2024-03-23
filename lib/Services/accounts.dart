import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kidspace/Screens/AccountsScreen/account.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Services/shared_prefs.dart';

class UserData {
  final dio = Dio();
  List<dynamic> dataList = [];
  var addUrl = '${Api().api}accounts';
  var getUrl = '${Api().api}my-accounts';

  //ADD USER
  addUserAccount(accountName, image, token) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name": accountName,
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
      });

      String? token = await SharedPrefData().getTokenFromSharedPrefs();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await dio.post(
        addUrl,
        data: formData,
        options: Options(headers: headers),
      );

      if (response.data['status'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  //DISPLAY USER
  get_user_account(token) async {
    try {
      String? token = await SharedPrefData().getTokenFromSharedPrefs();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response =
          await dio.get(getUrl, options: Options(headers: headers));
      var data = response.data;
      if (data['status'] == 200) {
        print(data);
        return data['data'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error occoured: $e');
    }
  }

  //UPDATE USER
  update_user_account(context, accountName, image, token, id, prevImage) async {
    try {
      int userId = id;

      String? token = await SharedPrefData().getTokenFromSharedPrefs();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      FormData formData;

      if (image == null) {
        formData = FormData.fromMap({
          "name": accountName,
        });
      } else if (accountName == "") {
        String fileName = image.path.split('/').last;
        formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(image.path, filename: fileName),
        });
      } else {
        String fileName = image.path.split('/').last;
        formData = FormData.fromMap({
          "name": accountName,
          "image": await MultipartFile.fromFile(image.path, filename: fileName),
        });
      }
      final response = await dio.post("${Api().api}accounts/$userId",
          data: formData, options: Options(headers: headers));

      if (response.data['status'] == 200) {
        print('Data updated successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Account()),
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Data updated successfully',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 74, 64, 255),
        ));

      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  // DELETE USER
  delete_user_account(context, userId) async {
    try {
      String? token = await SharedPrefData().getTokenFromSharedPrefs();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      int id = userId;
      final response = await dio.get('$addUrl/$id',
          options: Options(headers: headers));
      if (response.data['status'] == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Account()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Data deleted successfully.',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 74, 64, 255),
        ));
        
      }

    } catch (e) {
      print('Error occoured: $e');
    }
  }

   void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

}
