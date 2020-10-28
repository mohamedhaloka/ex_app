import 'package:ex/const.dart';
import 'package:ex/views/sign_up/terms_policy.dart';
import 'file:///C:/Users/laptop/IdeaProjects/ex/lib/widget/containerIcon.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'form.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with TickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
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
    return Container(
      decoration: bgDecoration,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Scaffold(
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
                      Transform(
                          transform: Matrix4.translationValues(
                              animation.value * customWidth(context, 1), 0, 0),
                          child: ContainerIcon()),
                      CustomSizedBox(wedNum: 0.0, heiNum: 0.04),
                      Transform(
                        transform: Matrix4.translationValues(
                            delayedAnimation.value * customWidth(context, 1),
                            0,
                            0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontFamily: "Bosca",
                              fontSize: 40,
                              color: subAccentColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
                      Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value *
                                  customWidth(context, 1),
                              0,
                              0),
                          child: SignUpForm()),
                    ],
                  ),
                ),
              )),
    );
  }
}
