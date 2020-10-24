import 'package:ex/views/sign_in/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../const.dart';

class AccountHeader extends StatefulWidget {
  @override
  _AccountHeaderState createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  String name, photo;
  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('displayName');
      photo = sharedPreferences.getString('photo');
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserName();
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: subAccentColor,
                    image: DecorationImage(
                        image: NetworkImage("$photo"), fit: BoxFit.cover)),
              ),
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool("seen", false);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignInView()));
                  })
            ],
          ),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
          Text(
            "$name",
            style: TextStyle(
                fontFamily: "Bosca",
                fontSize: 40,
                color: accentColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
