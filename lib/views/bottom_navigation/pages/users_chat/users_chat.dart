import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/models/message_model.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/chat/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../const.dart';

class UsersChat extends StatefulWidget {
  @override
  _UsersChatState createState() => _UsersChatState();
}

class _UsersChatState extends State<UsersChat> {
  String localId, name;

  getLocalId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      localId = sharedPreferences.getString('localId');
      name = sharedPreferences.getString('displayName');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalId();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Store().getUserChatMessages(localId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> user = [];
            List<Message> userMessageDetails = [];
            for (var doc in snapshot.data.docs) {
              Timestamp time = doc.data()[kMessageTime];
              var data = doc.data();
              user.add(User(
                  name: data[kUserName],
                  photo: data[kUserPhoto],
                  from: data[kFromUser],
                  to: data[kToUser],
                  id: doc.id));
              userMessageDetails.add(Message(
                text: data[kMessageTittle],
                image: data[kMessageFile],
                newMessage: data[kNewMessage],
                id: doc.id,
                time: DateFormat('kk:mm').format(time.toDate()),
              ));
            }
            return snapshot.data.docs.length == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/no-message.png",
                        color: accentColor,
                        width: 60,
                      ),
                      Text("No Message Yet")
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: RaisedButton(
                              padding: EdgeInsets.all(10),
                              onLongPress: () {
                                _openChatDialog(context, user[index].id);
                              },
                              onPressed: () {
                                Store().updateUsersChatMessages(
                                    localId, user[index].id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatView(
                                          user: user[index],
                                        )));
                              },
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showUserDialog(context, user[index]);
                                    },
                                    child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    user[index].photo),
                                                fit: BoxFit.cover))),
                                  ),
                                  CustomSizedBox(wedNum: 0.04, heiNum: 0.0),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${user[index].name}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: subAccentColor),
                                          ),
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: userMessageDetails[index]
                                                        .newMessage
                                                    ? accentColor
                                                    : Colors.transparent),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                userMessageDetails[index]
                                                            .text ==
                                                        ""
                                                    ? "تم إرسال صورة"
                                                    : "${userMessageDetails[index].text}",
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Text(
                                            "${userMessageDetails[index].time}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                                ],
                              ),
                              elevation: 0.0,
                              highlightElevation: 0.0,
                              splashColor: Colors.black12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 40, left: 70),
                            child: Divider(
                              height: 0,
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: user.length,
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  _showUserDialog(context, User userData) {
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
                      bottom: 0,
                      child: Container(
                        width: customWidth(context, 1),
                        height: 40,
                        color: Colors.black45,
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(userData.name),
                      ),
                      bottom: 0,
                    ),
                  ],
                ),
              ),
            ));
  }

  _openChatDialog(context, chatUserId) {
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
