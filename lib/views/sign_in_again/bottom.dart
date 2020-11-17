import 'package:ex/views/bottom_navigation/view.dart';
import 'package:ex/widget/register_button.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class SignInAgainBottom extends StatelessWidget {
  SignInAgainBottom({@required this.muchDelayedAnimation});
  Animation muchDelayedAnimation;
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
          muchDelayedAnimation.value *
              customWidth(context, 1),
          0,
          0),
      child: RegisterButton(
          function: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        BottomNavigationBarView()));
          },
          fillColors: [accentColor, subAccentColor],
          border: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Finish",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 20),
              ),
              Icon(
                Icons.check,
                color: primaryColor,
              )
            ],
          )),
    );
  }
}
