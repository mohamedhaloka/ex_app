import 'package:ex/const.dart';
import 'package:flutter/material.dart';

class ContainerIcon extends StatelessWidget {
  ContainerIcon({this.size});
  double size;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: size == null ? 55 : size,
      fit: BoxFit.cover,
    );
  }
}
