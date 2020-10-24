import 'package:flutter/material.dart';

import '../../const.dart';
import '../../widget/custom_app_bar.dart';

class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black26,
        appBar: customAppBar(context,"About ex"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
        ),
      ),
    );
  }
}
