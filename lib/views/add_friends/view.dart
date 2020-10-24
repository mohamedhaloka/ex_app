import 'package:ex/const.dart';
import 'package:ex/views/add_friends/search_friends.dart';
import 'package:ex/views/bottom_navigation/pages/users_chat/chats_header.dart';
import 'package:flutter/material.dart';

class AddFriendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ChatsHeader(tittle: "Add Friends",),
              SearchFriends()
            ],
          ),
        ),
      ),
    );
  }
}
