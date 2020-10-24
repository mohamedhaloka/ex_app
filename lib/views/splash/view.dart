import 'dart:async';

import 'package:ex/const.dart';
import 'package:ex/views/bottom_navigation/view.dart';
import 'package:ex/views/sign_in/view.dart';
import 'file:///C:/Users/laptop/IdeaProjects/ex/lib/widget/containerIcon.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigationBarView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDecoration,
        child: Scaffold(
          backgroundColor: Colors.black26,
          body: Center(
            child: ContainerIcon(
              size: 120,
            ),
          ),
        ));
  }
}
