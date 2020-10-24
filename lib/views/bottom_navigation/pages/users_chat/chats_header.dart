import 'package:ex/const.dart';
import 'package:flutter/material.dart';

class ChatsHeader extends StatelessWidget {
  ChatsHeader({this.tittle});
  String tittle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Stack(
          children: [
            Positioned(
              bottom: 26,
              right: 0,
              child: Container(
                width: 100,
                height: 6,
                color: Colors.white,
              ),
            ),
            Text(
              "$tittle".toUpperCase(),
              style: TextStyle(
                  color: accentColor,
                  fontSize: 40,
                  fontFamily: "Bosca",
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
