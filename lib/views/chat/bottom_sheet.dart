import 'package:clipboard/clipboard.dart';
import 'package:easy_alert/easy_alert.dart';
import 'package:ex/models/message_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

class BottomSheetModel {
  displayBottomSheet(BuildContext context, Message message, id, anotherUserId,messageID) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: 120,
            child: Column(
              children: [
                drawButton(Icons.delete, () {
                  Navigator.pop(context);
                  Store().deleteMessage(id, anotherUserId,messageID);
                }, "Delete Message"),
                drawButton(Icons.copy, () {
                  Navigator.pop(context);
                  FlutterClipboard.copy('${message.text}').then((value) {
                    Alert.toast(context, "Message Copied",
                        position: ToastPosition.bottom,
                        duration: ToastDuration.long);
                  });
                }, "Copy")
              ],
            ),
          );
        });
  }

  drawButton(icon, onPress, tittle) {
    return ListTile(
      leading: Icon(icon),
      onTap: onPress,
      title: Text(tittle),
    );
  }
}
