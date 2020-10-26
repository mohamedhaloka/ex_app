import 'package:flutter/cupertino.dart';

class NotificationStatue extends ChangeNotifier {
  bool notification = true;

  changeValOfNotification(val) {
    notification = val;
    notifyListeners();
  }
}
