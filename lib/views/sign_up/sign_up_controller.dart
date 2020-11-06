import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/bottom_navigation/view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ex/views/sign_up/sign_up_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';

class SignUpController {
  SignUpModel signUpModel = SignUpModel();

  Future<SignUpModel> signUp({email, password, displayName, context}) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC4w_3AH0qog39QkLHh8C-yOWbYPZEYcu8";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    http.Response response = await http.post(url,
        body: json.encode({
          'email': email,
          'displayName': displayName,
          'password': password,
        }));
    var userData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      sharedPreferences.setString('displayName', userData['displayName']);
      sharedPreferences.setString('idToken', userData['idToken']);
      sharedPreferences.setString('expiresIn', userData['expiresIn']);
      sharedPreferences.setString('email', userData['email']);
      sharedPreferences.setString('localId', userData['localId']);
      sharedPreferences.setBool("seen", true);
      FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
      String _fcmToken = await _firebaseMessaging.getToken();
      sharedPreferences.setString('fcmToken', _fcmToken);
      Store().storeUserDate(userData['localId'], {
        kUserName: userData['displayName'],
        kUserEmail: email,
        kUserLocalId: userData['localId'],
        kUserStatue: "Hey there! I am using EX",
        kUserPhoto: "https://f.top4top.io/p_17582zi971.jpg",
        kUserFCMToken: _fcmToken,
      });
      await FirebaseFirestore.instance
          .collection(kUserCollection)
          .doc(userData['localId'])
          .get()
          .then((value) {
        sharedPreferences.setString('photo', value.get(kUserPhoto));
        sharedPreferences.setString('statue', value.get(kUserStatue));
        print(value.get(kUserPhoto));
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigationBarView()));
      return SignUpModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      var errorMessage = json.decode(response.body)['error']['message'];
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        duration: Duration(milliseconds: 600),
      ));
    }
    print(response.statusCode);
    print(response.body);
  }
}
