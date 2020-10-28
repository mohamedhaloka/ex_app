import 'package:ex/const.dart';
import 'package:ex/widget/containerIcon.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

import 'form.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with TickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;

  @override
  void initState() {
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
                          "Sign In",
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
                          child: SignInForm())
                    ],
                  ),
                ),
              )),
    );
  }
}
