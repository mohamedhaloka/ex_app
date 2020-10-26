import 'package:flutter/cupertino.dart';

const Color primaryColor = Color(0xff3B3D40);
const Color secondaryColor = Color(0xff060808);
const Color accentColor = Color(0xff9F8E65);
const Color subAccentColor = Color(0xffC6B17C);

//UserCollection
const String kUserCollection = "users";
const String kUserPhoto = "user photo";
const String kUserName = "user name";
const String kUserStatue = "user statue";
const String kUserEmail = "user email";
const String kUserLocalId = "user localId";

//UsersChat
const String kUsersChatCollection = "users chat";


//MessageCollection
const String kMessagesCollection = "messages";
const String kMessageTittle = "message text";
const String kMessageTime = "message time";
const String kMessageFile = "message file";
const String kNewMessage = "new message";
const String kToUser = "to";
const String kFromUser = "from";

customHeight(context, heiNum) {
  return MediaQuery.of(context).size.height * heiNum;
}

customWidth(context, wedNum) {
  return MediaQuery.of(context).size.width * wedNum;
}

BoxDecoration bgDecoration = BoxDecoration(
    gradient: LinearGradient(
        colors: [primaryColor, secondaryColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        tileMode: TileMode.mirror));
