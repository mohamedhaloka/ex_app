import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../../const.dart';

class BottomBarStyle {
  SnakeShape customSnakeShape = SnakeShape(
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      centered: true);
  ShapeBorder customBottomBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25), topRight: Radius.circular(25)),
  );
  ShapeBorder customBottomBarShape1 = BeveledRectangleBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25), topRight: Radius.circular(25)),
  );

  SnakeBarStyle snakeBarStyle = SnakeBarStyle.pinned;
  SnakeShape snakeShape = SnakeShape.indicator;
  double elevation = 0;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color backgroundColor = secondaryColor;
  Color selectionColor = subAccentColor;

  Gradient backgroundGradient =
      const LinearGradient(colors: [Colors.black, Colors.lightBlue]);
  Gradient selectionGradient =
      const LinearGradient(colors: [Colors.white, Colors.amber]);

  EdgeInsets padding = EdgeInsets.all(12);
  Color containerColor = Color(0xFFFDE1D7);
  TextStyle labelTextStyle = TextStyle(
      fontSize: 11, fontFamily: 'Ubuntu', fontWeight: FontWeight.bold);
}
