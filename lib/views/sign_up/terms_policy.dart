import 'package:ex/views/terms_and_conditions/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../privacy_policy/view.dart';

class TermsAndPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By creating an account you agree with our ',
        style: TextStyle(color: Colors.grey[600]),
        children: [
          TextSpan(
              text: 'Terms of Use',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditions()));
                },
              style: TextStyle(
                  color: Colors.grey[800],
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold)),
          TextSpan(text: ' and ', style: TextStyle(color: Colors.grey[600])),
          TextSpan(
              text: 'Privacy Policy',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
              style: TextStyle(
                  color: Colors.grey[800],
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
