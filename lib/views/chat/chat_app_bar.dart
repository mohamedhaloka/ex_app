import 'package:ex/models/user_model.dart';
import 'package:ex/views/user_details/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

chatAppBar(context, User user, localId, email, name) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: secondaryColor,
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff131619), Color(0xff0b0d0f)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.mirror)),
    ),
    title: RaisedButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserDetailsView(user, localId, email, name))),
      elevation: 0.0,
      highlightElevation: 0.0,
      padding: EdgeInsets.all(0.0),
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(user.photo), fit: BoxFit.cover)),
          ),
          CustomSizedBox(wedNum: 0.02, heiNum: 0.0),
          Column(
            children: [
              Text(
                "${user.name}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: subAccentColor),
              ),
              // Text(
              //  user.userStatue=="typing"? "typing":"",
              //   style: TextStyle(
              //       fontSize: 12,
              //       color: Colors.white),
              // ),
            ],
          ),
        ],
      ),
    ),
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: subAccentColor,
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}
