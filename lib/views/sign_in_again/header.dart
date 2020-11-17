import 'package:flutter/material.dart';

import '../../const.dart';

class SignInAgainHeader extends StatelessWidget {
  SignInAgainHeader({@required this.name, @required this.animation});
  Animation animation;
  String name;
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
          animation.value * customWidth(context, 1), 0, 0),
      child: Column(
        children: [
          Text(
            "Nice to see you again, $name",
            style: TextStyle(
                fontFamily: "Bosca",
                fontSize: 39,
                color: subAccentColor,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "Look good. Tap on finish to start chating.",
            style: TextStyle(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
