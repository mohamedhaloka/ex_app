import 'package:ex/const.dart';
import 'package:ex/views/sign_up/terms_policy.dart';
import 'file:///C:/Users/laptop/IdeaProjects/ex/lib/widget/containerIcon.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'form.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        appBar: signUpAbbBar(context),
        backgroundColor: Colors.black26,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 40,
              right: 40,
              bottom: 10,
              top: customHeight(context, 0.1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerIcon(),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.04),
              Text(
                "Sign Up",
                style: TextStyle(
                    fontFamily: "Bosca",
                    fontSize: 40,
                    color: subAccentColor,
                    fontWeight: FontWeight.w500),
              ),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
              SignUpForm(),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
              TermsAndPolicy(),
              CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
