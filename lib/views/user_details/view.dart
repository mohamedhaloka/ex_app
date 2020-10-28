import 'package:easy_alert/easy_alert.dart';
import 'package:ex/const.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/bottom_navigation/pages/users_chat/user_chats_functions.dart';
import 'package:ex/views/bottom_navigation/pages/users_chat/view.dart';
import 'package:ex/views/bottom_navigation/view.dart';
import 'package:ex/views/user_details/email_and_statue.dart';
import 'package:ex/views/user_details/user_details_buttons.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class UserDetailsView extends StatelessWidget {
  UserDetailsView(this.userDetails, this.localId, this.email, this.name);
  User userDetails;
  String localId;
  String email;
  String name;
  var dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              centerTitle: false,
              expandedHeight: customHeight(context, 0.4),
              actions: [
                IconButton(
                    icon: Icon(Icons.share_rounded),
                    onPressed: () {
                      Share.share(
                          "User Name is ${userDetails.name} and Email is ${userDetails.email}");
                    })
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  "${userDetails.photo}",
                  fit: BoxFit.cover,
                ),
                title: Text(
                  '${userDetails.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 16.0),
                child: Column(
                  children: [
                    EmailAndStatue(
                      userEmail: userDetails.email,
                      userStatue: userDetails.statue,
                    ),
                    CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
                    UserDetailsButton(
                      tittle: "Report",
                      icon: Icons.report_gmailerrorred_rounded,
                      onTap: () {
                        openChatDialog(context, userDetails.id, localId);
                        Navigator.maybePop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersChatView()));
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  openChatDialog(context, chatUserId, localId) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Ok, Do you want delete this chat with your report?"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Store().deleteChat(localId, chatUserId);
                      Store().deleteChatMessages(
                        localId,
                        chatUserId,
                      );
                      Store().storeUserReports(localId,
                          {kFromUserEmail: email, kFromUserName: name});
                      Store().storeUserReportLogs(localId, {
                        kToUserEmail: userDetails.email,
                        kFromUserEmail: email,
                        kToUserName: userDetails.name,
                        kFromUserName: name,
                        kReportTime: dateTime
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigationBarView()));
                      Alert.toast(context, "Send report successfully",
                          position: ToastPosition.bottom,
                          duration: ToastDuration.long);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.red[900]),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Store().storeUserReports(localId,
                          {kFromUserEmail: email, kFromUserName: name});
                      Store().storeUserReportLogs(localId, {
                        kToUserEmail: userDetails.email,
                        kFromUserEmail: email,
                        kToUserName: userDetails.name,
                        kFromUserName: name,
                        kReportTime: dateTime
                      });
                      Alert.toast(context, "Send report successfully",
                          position: ToastPosition.bottom,
                          duration: ToastDuration.long);
                    },
                    child: Text("No")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            ));
  }
}
