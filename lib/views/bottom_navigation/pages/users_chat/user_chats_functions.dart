import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/chat/view.dart';
import 'package:ex/views/user_details/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../const.dart';

class UserChatsFunctions {
  showUserDialog(context, User userData, localId, email, name) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(userData.photo),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: customWidth(context, 1),
                        height: 40,
                        color: Colors.black45,
                      ),
                      bottom: 0,
                    ),
                    Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(userData.name),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                Navigator.pop(context);
                                Store().updateUsersChatMessages(
                                    localId, userData.id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatView(
                                          user: userData,
                                        )));
                              },
                              color: secondaryColor,
                            ),
                            IconButton(
                              icon: Icon(Icons.info_outline_rounded),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserDetailsView(
                                        userData, localId, name, email)));
                              },
                              color: secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  openChatDialog(context, chatUserId, localId) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Do you want delete this chat?"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Store().deleteChat(localId, chatUserId);
                      Store().deleteChatMessages(
                        localId,
                        chatUserId,
                      );
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.red[900]),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            ));
  }
}
