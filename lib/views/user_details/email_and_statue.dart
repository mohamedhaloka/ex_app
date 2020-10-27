import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const.dart';

class EmailAndStatue extends StatelessWidget {
  EmailAndStatue({@required this.userEmail, @required this.userStatue});
  String userEmail;
  String userStatue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black45,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About and email",
            style: TextStyle(
                color: accentColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "$userStatue",
            style: TextStyle(fontSize: 20),
          ),
          Divider(
            color: primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$userEmail",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: accentColor,
                  ),
                  IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () {
                      _sendEmail("mailto:${userEmail}");
                    },
                    color: accentColor,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  _sendEmail(email) async {
    if (await canLaunch(email)) {
      await launch(email);
    } else {
      throw 'Could not launch $email';
    }
  }
}
