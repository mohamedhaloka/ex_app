import 'package:ex/models/user_model.dart';
import 'package:ex/views/user_details/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

chatAppBar(context, User user, localId, email, name) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    title: GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserDetailsView(user, localId, email, name))),
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
          Text(
            "${user.name}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: subAccentColor),
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
