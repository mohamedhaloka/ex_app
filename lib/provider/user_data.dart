import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier{

  String userName;

  changeUserName(val)
  {
    userName = val;
    notifyListeners();
  }
}