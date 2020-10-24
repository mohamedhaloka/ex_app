import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/const.dart';
import 'package:flutter/material.dart';
import 'package:ex/views/sign_in/sign_in_model.dart';
import 'package:ex/views/sign_in_again/view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInController {
  SignInModel signInModel = SignInModel();

  Future<SignInModel> signIn(email, password, context) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC4w_3AH0qog39QkLHh8C-yOWbYPZEYcu8";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
        }));
    var userData = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      sharedPreferences.setString("displayName", userData['displayName']);
      sharedPreferences.setString('idToken', userData['idToken']);
      sharedPreferences.setString('localId', userData['localId']);
      sharedPreferences.setString('expiresIn', userData['expiresIn']);
      sharedPreferences.setString('email', userData['email']);
      sharedPreferences.setBool("seen", true);
      await FirebaseFirestore.instance
          .collection(kUserCollection)
          .doc(userData['localId'])
          .get()
          .then((value) {
        sharedPreferences.setString('photo', value.get(kUserPhoto));
        sharedPreferences.setString('statue', value.get(kUserStatue));
        print(value.get(kUserPhoto));
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInAgain()));
      return SignInModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      var errorMessage = json.decode(response.body)['error']['message'];
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        duration: Duration(milliseconds: 600),
      ));
    }
    print(response.statusCode);
  }
}
