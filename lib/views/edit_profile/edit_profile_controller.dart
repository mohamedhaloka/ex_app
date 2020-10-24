import 'dart:convert';

import 'package:easy_alert/easy_alert.dart';
import 'package:ex/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ex/views/edit_profile/edit_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController {
  EditProfileModel editProfileModel = EditProfileModel();

  // ignore: missing_return
  Future<EditProfileModel> editProfile(idToken, displayName, password, photoUrl,
      email, data, context, statueDes) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyC4w_3AH0qog39QkLHh8C-yOWbYPZEYcu8";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.post(url,
        body: json.encode({
          "idToken": idToken,
          "displayName": displayName,
          "passwordHash": password,
          "email": email,
          "photoUrl": photoUrl
        }));
    var userData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      sharedPreferences.setString('displayName', userData['displayName']);
      sharedPreferences.setString('photoUrl', userData['photoUrl']);
      sharedPreferences.setString('localId', userData['localId']);
      sharedPreferences.setString('statue', statueDes);
      Store().editProfile(userData['localId'], data);
      Navigator.pop(context);
      Alert.toast(context, "Your information has been successfully updated",
          position: ToastPosition.bottom, duration: ToastDuration.long);
      return EditProfileModel.fromJson(json.decode(response.body));
    } else {
      print("ERRPR");
    }
  }
}
