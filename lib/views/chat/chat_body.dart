import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/models/message_model.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/chat/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../const.dart';

class ChatBody extends StatefulWidget {
  ChatBody({this.id, this.user, this.localId});
  String id;
  User user;
  String localId;

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Store().getMessages(widget.localId, widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messages = [];
            for (var doc in snapshot.data.docs) {
              Timestamp time = doc.data()[kMessageTime];
              messages.add(Message(
                text: doc.data()[kMessageTittle],
                from: doc.data()[kFromUser],
                image: doc.data()[kMessageFile],
                id: doc.id,
                to: widget.user.id,
                time: DateFormat('yyyy-MM-dd – kk:mm').format(time.toDate()),
              ));
            }
            return ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) {
                return Align(
                  alignment: widget.localId == messages[index].from
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: UnconstrainedBox(
                    child: GestureDetector(
                      onLongPress: () {
                        BottomSheetModel().displayBottomSheet(
                            context,
                            messages[index],
                            widget.localId,
                            widget.id,
                            messages[index].id);
                      },
                      child: Container(
                        width: customWidth(context, 0.5),
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: widget.localId == messages[index].from
                              ? BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))
                              : BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                          gradient: LinearGradient(
                              colors: widget.localId == messages[index].from
                                  ? [accentColor, subAccentColor]
                                  : [Colors.white, Colors.grey[300]],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.mirror),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              widget.localId == messages[index].from
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            messages[index].text == ""
                                ? GestureDetector(
                                    onTap: () {
                                      _showPhotoDialog(
                                          context, messages[index]);
                                    },
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${messages[index].image}"),
                                              fit: BoxFit.contain)),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      SelectableText(
                                        messages[index].text,
                                        textAlign: widget.localId ==
                                                messages[index].from
                                            ? TextAlign.right
                                            : TextAlign.left,
                                        style: TextStyle(
                                          color: widget.localId ==
                                                  messages[index].from
                                              ? Colors.white
                                              : accentColor,
                                        ),
                                      ),
                                      Visibility(
                                        child: GestureDetector(
                                          onTap: () {
                                            _showPhotoDialog(
                                                context, messages[index]);
                                          },
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${messages[index].image}"),
                                                    fit: BoxFit.contain)),
                                          ),
                                        ),
                                        visible: messages[index].image == null
                                            ? false
                                            : true,
                                      ),
                                    ],
                                  ),
                            Text(
                              messages[index].time,
                              style: TextStyle(
                                  color: widget.localId == messages[index].from
                                      ? Colors.white
                                      : accentColor,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: messages.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  _showPhotoDialog(context, Message messageInfo) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              content: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage("${messageInfo.image}"),
                )),
              ),
            ));
  }
}
