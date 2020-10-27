import 'package:ex/const.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/views/user_details/email_and_statue.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class UserDetailsView extends StatelessWidget {
  UserDetailsView(this.userDetails);
  User userDetails;
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
              floating: false,
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
}
