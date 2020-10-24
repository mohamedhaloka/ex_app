import 'package:ex/const.dart';
import 'package:ex/widget/containerIcon.dart';
import 'package:ex/widget/custom_app_bar.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black26,
        appBar: customAppBar(context, "Terms And Conditions"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 35,
              right: 35,
              top: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ContainerIcon(),
                CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
                SelectableText(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
