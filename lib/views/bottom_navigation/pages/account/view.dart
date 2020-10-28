import 'package:ex/views/sign_up/terms_policy.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'account_buttons.dart';
import 'account_header.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
      child: Column(
        children: [
          AccountHeader(),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
          AccountButtons(),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
          TermsAndPolicy(isSignUp: false,)
        ],
      ),
    );
  }
}
