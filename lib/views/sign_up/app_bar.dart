import 'package:ex/const.dart';
import 'package:flutter/material.dart';

signUpAbbBar(context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: subAccentColor,
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}
