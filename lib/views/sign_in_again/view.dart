import 'package:ex/views/bottom_navigation/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:ex/widget/register_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';

class SignInAgain extends StatefulWidget {
  @override
  _SignInAgainState createState() => _SignInAgainState();
}

class _SignInAgainState extends State<SignInAgain> {
  String name, photo;

  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('displayName');
      photo = sharedPreferences.getString('photo');
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 40,
              right: 40,
              bottom: 10,
              top: customHeight(context, 0.15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.06),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor,
                    image: DecorationImage(
                        image: NetworkImage("$photo"), fit: BoxFit.cover)),
              ),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.12),
              RegisterButton(
                  function: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BottomNavigationBarView()));
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
