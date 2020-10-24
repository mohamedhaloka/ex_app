import 'package:ex/const.dart';
import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  CustomSizedBox({@required this.wedNum, @required this.heiNum});
  double heiNum;
  double wedNum;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customHeight(context, heiNum),
      width: customWidth(context, wedNum),
    );
  }
}
