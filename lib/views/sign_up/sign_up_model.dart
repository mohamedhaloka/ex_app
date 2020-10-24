// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.kind,
    this.idToken,
    this.displayName,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
  });

  String kind;
  String idToken;
  String displayName;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    kind: json["kind"] == null ? null : json["kind"],
    idToken: json["idToken"] == null ? null : json["idToken"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    email: json["email"] == null ? null : json["email"],
    refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
    expiresIn: json["expiresIn"] == null ? null : json["expiresIn"],
    localId: json["localId"] == null ? null : json["localId"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind == null ? null : kind,
    "idToken": idToken == null ? null : idToken,
    "displayName": displayName == null ? null : displayName,
    "email": email == null ? null : email,
    "refreshToken": refreshToken == null ? null : refreshToken,
    "expiresIn": expiresIn == null ? null : expiresIn,
    "localId": localId == null ? null : localId,
  };
}
