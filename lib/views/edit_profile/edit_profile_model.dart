// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  EditProfileModel({
    this.kind,
    this.localId,
    this.email,
    this.displayName,
    this.providerUserInfo,
    this.photoUrl,
    this.passwordHash,
    this.emailVerified,
  });

  String kind;
  String localId;
  String email;
  String displayName;
  List<ProviderUserInfo> providerUserInfo;
  String photoUrl;
  String passwordHash;
  bool emailVerified;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
    kind: json["kind"] == null ? null : json["kind"],
    localId: json["localId"] == null ? null : json["localId"],
    email: json["email"] == null ? null : json["email"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    providerUserInfo: json["providerUserInfo"] == null ? null : List<ProviderUserInfo>.from(json["providerUserInfo"].map((x) => ProviderUserInfo.fromJson(x))),
    photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
    passwordHash: json["passwordHash"] == null ? null : json["passwordHash"],
    emailVerified: json["emailVerified"] == null ? null : json["emailVerified"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind == null ? null : kind,
    "localId": localId == null ? null : localId,
    "email": email == null ? null : email,
    "displayName": displayName == null ? null : displayName,
    "providerUserInfo": providerUserInfo == null ? null : List<dynamic>.from(providerUserInfo.map((x) => x.toJson())),
    "photoUrl": photoUrl == null ? null : photoUrl,
    "passwordHash": passwordHash == null ? null : passwordHash,
    "emailVerified": emailVerified == null ? null : emailVerified,
  };
}

class ProviderUserInfo {
  ProviderUserInfo({
    this.providerId,
    this.displayName,
    this.photoUrl,
    this.federatedId,
    this.email,
    this.rawId,
  });

  String providerId;
  String displayName;
  String photoUrl;
  String federatedId;
  String email;
  String rawId;

  factory ProviderUserInfo.fromJson(Map<String, dynamic> json) => ProviderUserInfo(
    providerId: json["providerId"] == null ? null : json["providerId"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
    federatedId: json["federatedId"] == null ? null : json["federatedId"],
    email: json["email"] == null ? null : json["email"],
    rawId: json["rawId"] == null ? null : json["rawId"],
  );

  Map<String, dynamic> toJson() => {
    "providerId": providerId == null ? null : providerId,
    "displayName": displayName == null ? null : displayName,
    "photoUrl": photoUrl == null ? null : photoUrl,
    "federatedId": federatedId == null ? null : federatedId,
    "email": email == null ? null : email,
    "rawId": rawId == null ? null : rawId,
  };
}
