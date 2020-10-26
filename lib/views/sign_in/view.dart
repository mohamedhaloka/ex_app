import 'package:ex/const.dart';
import 'package:ex/widget/containerIcon.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

import 'form.dart';

class SignInView extends StatelessWidget {
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
              top: customHeight(context, 0.25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerIcon(),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.04),
              Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: "Bosca",
                    fontSize: 40,
                    color: subAccentColor,
                    fontWeight: FontWeight.w500),
              ),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
              SignInForm()
            ],
          ),
        ),
      ),
    );
  }
}
