import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/models/message_model.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/chat/view.dart';
import 'package:ex/widget/custom_sized_box.dart';
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatView(
                                          user: user[index],
                                        )));
                              },
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  user[index].photo),
                                              fit: BoxFit.cover))),
                                  CustomSizedBox(wedNum: 0.04, heiNum: 0.0),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${user[index].name}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: subAccentColor),
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
}
