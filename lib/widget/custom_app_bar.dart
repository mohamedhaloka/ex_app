import 'package:flutter/material.dart';

import '../const.dart';

customAppBar(context,tittle) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text(
      "$tittle".toUpperCase(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: subAccentColor,
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}
