import 'package:ex/views/about/view.dart';
import 'package:ex/views/edit_profile/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../const.dart';

class AccountButtons extends StatefulWidget {
  @override
  _AccountButtonsState createState() => _AccountButtonsState();
}

class _AccountButtonsState extends State<AccountButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          drawButton(context, "Edit Profile", "Tell us your preferences",
              EditProfile()),
          CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
          drawButton(
              context, "About ex", "A few words from the creators", AboutUS()),
        ],
      ),
    );
  }

  Widget drawButton(context, tittle, subTittle, page) {
    return Container(
      width: customWidth(context, 1),
      height: 118,
      color: Colors.white,
      child: RaisedButton(
        onPressed: tittle == "Notification"
            ? null
            : () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => page));
              },
        color: Colors.transparent,
        elevation: 0.0,
        highlightElevation: 0.0,
        splashColor: Colors.black26,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$tittle".toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    "$subTittle".toUpperCase(),
                    style: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/images/right-arrow.png",
              width: 40,
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }
}
