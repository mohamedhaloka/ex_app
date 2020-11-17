import 'package:ex/views/bottom_navigation/view.dart';
import 'package:ex/views/sign_in_again/bottom.dart';
import 'package:ex/views/sign_in_again/header.dart';
import 'package:ex/views/sign_in_again/photo.dart';
import 'package:ex/widget/cached_network_image.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:ex/widget/register_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';

class SignInAgain extends StatefulWidget {
  @override
  _SignInAgainState createState() => _SignInAgainState();
}

class _SignInAgainState extends State<SignInAgain>
    with TickerProviderStateMixin {
  String name, photo;
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;

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
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: animationController));
    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Container(
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
                      SignInAgainHeader(name: name, animation: animation),
                      CustomSizedBox(wedNum: 0.0, heiNum: 0.06),
                      SignInAgainPhoto(
                          photo: photo, delayedAnimation: delayedAnimation),
                      CustomSizedBox(wedNum: 0.0, heiNum: 0.12),
                      SignInAgainBottom(muchDelayedAnimation: muchDelayedAnimation)
                    ],
                  ),
                ),
              ),
            ));
  }
}
