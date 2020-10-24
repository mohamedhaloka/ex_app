import 'package:ex/services/store.dart';
import 'package:ex/views/bottom_navigation/view.dart';
import 'package:ex/views/sign_up/sign_up_controller.dart';
import 'package:ex/views/sign_up/sign_up_model.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:ex/widget/register_button.dart';
import 'package:ex/widget/register_text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String name, email, password, localId;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpController signUpController = SignUpController();
  SignUpModel signUpModel = SignUpModel();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RegisterTextField(
            tittle: "name",
            hintTittle: "example: Mohamed Nasr",
            onSaved: (val) {
              setState(() {
                name = val;
              });
            },
          ),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
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
                  "Sign Up",
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
              _signUp(context);
            },
            fillColors: [accentColor, subAccentColor],
          ),
        ],
      ),
    );
  }

  _signUp(context) async {
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _loading = true;
        });

        signUpModel = await signUpController.signUp(
            displayName: name,
            email: email,
            password: password,
            context: context);
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
