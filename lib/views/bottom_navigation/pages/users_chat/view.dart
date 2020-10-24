import 'package:ex/views/bottom_navigation/pages/users_chat/users_chat.dart';
import 'package:flutter/material.dart';

import 'chats_header.dart';

class UsersChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [
          ChatsHeader(tittle: "Chats",),
          UsersChat()
        ],
      ),
    );
  }
}
