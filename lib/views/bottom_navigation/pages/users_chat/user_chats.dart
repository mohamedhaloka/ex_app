import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/models/message_model.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/bottom_navigation/pages/users_chat/user_chats_functions.dart';
import 'package:ex/views/chat/view.dart';
import 'package:ex/views/user_details/view.dart';
import 'package:ex/widget/cached_network_image.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../const.dart';

class UsersChat extends StatefulWidget {
  @override
  _UsersChatState createState() => _UsersChatState();
}

class _UsersChatState extends State<UsersChat> {
  String localId, name, email;

  getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      localId = sharedPreferences.getString('localId');
      name = sharedPreferences.getString('displayName');
      email = sharedPreferences.getString('email');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
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
                  statue: data[kUserStatue],
                  email: data[kUserEmail],
                  to: data[kToUser],
                  token: data[kUserFCMToken],
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
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 700),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.only(right: 10, left: 10),
                                child: RaisedButton(
                                  padding: EdgeInsets.all(10),
                                  onLongPress: () {
                                    UserChatsFunctions().openChatDialog(
                                        context, user[index].id, localId);
                                  },
                                  onPressed: () {
                                    Store().updateUsersChatMessages(
                                        localId, user[index].id);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ChatView(
                                                  user: user[index],
                                                )));
                                  },
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          UserChatsFunctions().showUserDialog(
                                              context,
                                              user[index],
                                              localId,
                                              name,
                                              email);
                                        },
                                        child: cachedNetworkImage(
                                            height: 60.0,
                                            width: 60.0,
                                            imgSrc: user[index].photo,
                                            isCircle: true),
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
                                                    color: userMessageDetails[
                                                                index]
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
                                                child: userMessageDetails[index]
                                                            .text ==
                                                        ""
                                                    ? Row(
                                                        children: [
                                                          Text("تم إرسال صورة",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                          Icon(Icons.photo)
                                                        ],
                                                      )
                                                    : Text(
                                                        "${userMessageDetails[index].text}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis),
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
                          ));
                    },
                    itemCount: user.length,
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
