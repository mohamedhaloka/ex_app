import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_alert/easy_alert.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/chat/chat_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import '../../const.dart';
import 'chat_body.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  ChatView({this.user});
  User user;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  String message, localId, toUserName, photo, userPhoto, fcmToken;
  String _uploadedFileURL;
  String serverToken =
      "AAAAhtQmW4o:APA91bG9X9b9Lt6c5v9oh0-ToW7rLo41X99V_ryGibrFLNW1kxPL4FFQgr2yRB_tKrv1MD9KL2OMZ81Lvr0VIQjZiouOszHhwIh5xNLPCC2_oKIDCOWScOk3tU0R3L_74azs-x3zfEvn";
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  File _image;
  var dateTime = DateTime.now();
  getLocalId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      localId = sharedPreferences.getString("localId");
      toUserName = sharedPreferences.getString("displayName");
      photo = sharedPreferences.getString("photo");
      fcmToken = sharedPreferences.getString("fcmToken");
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.user.token);
    getLocalId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: chatAppBar(context, widget.user),
        body: Column(
          children: [
            Expanded(
                child: ChatBody(
                    user: widget.user, id: widget.user.id, localId: localId)),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: customWidth(context, 1),
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: controller,
                        cursorColor: accentColor,
                        onSaved: (val) {
                          setState(() {
                            message = val;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Type a message",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none))),
                      ),
                    ),
                  ),
                  drawButton(Icons.attach_file, () {
                    chooseFile();
                  }),
                  drawButton(Icons.send, () {
                    _sendMessage(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  drawButton(icon, onPress) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: RaisedButton(
        onPressed: onPress,
        elevation: 0.0,
        child: Icon(
          icon,
          size: 15,
          color: accentColor,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        color: Colors.transparent,
      ),
    );
  }

  _sendMessage(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (message.isNotEmpty || _uploadedFileURL.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection(kUserCollection)
            .doc(widget.user.id)
            .get()
            .then((value) async {
          setState(() {
            userPhoto = value.get(kUserPhoto);
          });
        });
        Store().storeUsersChatMessage(localId, widget.user.id,
            dateTime: dateTime,
            fromLocalId: localId,
            messageTittle: message,
            toLocalId: widget.user.id,
            username: widget.user.name,
            username2: toUserName,
            meToken: fcmToken,
            userToken: widget.user.token,
            mePhoto: photo,
            userPhoto: userPhoto,
            newMessage: true,
            newMessageLocal: false);
        Store().storeMessage(
            localId,
            {
              kMessageTittle: message,
              kMessageTime: dateTime,
              kFromUser: localId,
              kToUser: widget.user.id,
              kMessageFile: _uploadedFileURL
            },
            widget.user.id);

        sendAndRetrieveMessage(widget.user.token);
      } else {
        return;
      }

      setState(() {
        controller.text = "";
        _uploadedFileURL = null;
      });
    }
  }

  chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
      uploadFile();
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$localId/userFiles/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) async {
      setState(() {
        _uploadedFileURL = fileURL;
      });
      print(fileURL);
      print(_uploadedFileURL);
      Alert.toast(context, "Your Photo has been uploaded",
          position: ToastPosition.center, duration: ToastDuration.long);
    });
  }

  Future<Map<String, dynamic>> sendAndRetrieveMessage(userToken) async {
    print("HI");
    print(userToken);
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '$message',
            'title': '$toUserName'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': userToken,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
