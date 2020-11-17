import 'package:ex/widget/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class SignInAgainPhoto extends StatelessWidget {
  SignInAgainPhoto({@required this.photo, @required this.delayedAnimation});
  Animation delayedAnimation;
  String photo;
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
          delayedAnimation.value * customWidth(context, 1), 0, 0),
      child: cachedNetworkImage(imgSrc: photo, width: 130.0, height: 130.0),
    );
  }
}
