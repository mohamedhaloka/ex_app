import 'package:ex/const.dart';
import 'package:ex/views/sign_in/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int pageNumber = 0;
  int stepNumber = 1;
  List<String> images = [
    "assets/images/log-in.png",
    "assets/images/conversation.png",
    "assets/images/privacy.png"
  ];
  List<String> tittles = [
    "Easy Registration to Easy Chating",
    "Easy Chating with your friends",
    "Your Information is Secure with US"
  ];
  List<String> descries = [
    "You can create an account in 1 minute! , that is cool! .. to enter to the chat world and make a lot of friends.",
    "Easy user interface to rest while chatting with your friends and fast connect .. All in one in Ex's Chat.",
    "Do you worry about your information? Don't worry, all your information is locked, nobody can get it"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 40, left: 40, top: 40, bottom: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EX Chat",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Bosca",
                            color: subAccentColor),
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'step'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[300]),
                              children: [
                            TextSpan(
                                text: ' $stepNumber',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300])),
                            TextSpan(
                                text: '/3',
                                style: TextStyle(color: Colors.grey[500])),
                          ])),
                    ],
                  ),
                ),
                CustomSizedBox(wedNum: 0.0, heiNum: 0.08),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "${images[pageNumber]}",
                      width: 150,
                      color: accentColor,
                    ),
                    CustomSizedBox(wedNum: 0.0, heiNum: 0.04),
                    Text(
                      "${tittles[pageNumber]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Bosca",
                          fontSize: 30),
                    ),
                    CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
                    Text(
                      "${descries[pageNumber]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                    )
                  ],
                ),
                CustomSizedBox(wedNum: 0.0, heiNum: 0.1),
                Row(
                  mainAxisAlignment: pageNumber == 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (pageNumber <= 2) {
                          setState(() {
                            pageNumber--;
                            stepNumber--;
                          });
                        }
                      },
                      child: Visibility(
                          visible: pageNumber == 0 ? false : true,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: GestureDetector(
                              child: Image.asset(
                                "assets/images/right-arrow-onboarding.png",
                                color: accentColor,
                                width: 50,
                              ),
                            ),
                          )),
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (pageNumber < 2) {
                            setState(() {
                              pageNumber++;
                              stepNumber++;
                            });
                          } else {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setBool("seenOnBoarding", true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInView()));
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor,
                          ),
                          child: Image.asset(
                            "assets/images/right-arrow-onboarding.png",
                            width: 30,
                            height: 30,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
