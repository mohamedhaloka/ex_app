import 'package:ex/views/sign_in/sign_in_controller.dart';
import 'package:ex/views/sign_in/sign_in_model.dart';
import 'package:ex/views/sign_in_again/view.dart';
import 'package:ex/views/sign_up/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:ex/widget/register_button.dart';
import 'package:ex/widget/register_text_field.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String email, password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignInModel signInModel = SignInModel();
  SignInController signInController = SignInController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RegisterTextField(
            tittle: "email",
            hintTittle: "example@example.com",
            onSaved: (val) {
              setState(() {
                email = val;
              });
            },
          ),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
          RegisterTextField(
            tittle: "password",
            hintTittle: "**********",
            onSaved: (val) {
              setState(() {
                password = val;
              });
            },
          ),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.05),
          RegisterButton(
            border: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Log In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 20),
                ),
                _loading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        strokeWidth: 1,
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: primaryColor,
                      )
              ],
            ),
            function: () {
              _signIn(context);
            },
            fillColors: [accentColor, subAccentColor],
          ),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
          Builder(
              builder: (context) => RegisterButton(
                    border: accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: accentColor,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpView()));
                    },
                    fillColors: [Colors.transparent, Colors.transparent],
                  )),
        ],
      ),
    );
  }

  _signIn(context) async {
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _loading = true;
        });
        signInModel = await signInController.signIn(email, password, context);
        print(email);
      }
      setState(() {
        _loading = false;
      });
    } catch (e) {}
    setState(() {
      _loading = false;
    });
  }
}
