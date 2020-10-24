import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/const.dart';
import 'package:ex/models/user_model.dart';
import 'package:ex/services/store.dart';
import 'package:ex/views/chat/view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SearchFriends extends StatefulWidget {
  @override
  _SearchFriendsState createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  String filter;
  TextEditingController searchController = TextEditingController();
  String localId;
  getUsers() async {
    print(localId);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      localId = sharedPreferences.getString('localId');
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            cursorColor: accentColor,
            controller: searchController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: 'Search ...',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: Store().getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> users = [];
              for (var doc in snapshot.data.docs) {
                users.add(User(
                  email: doc.data()[kUserEmail],
                  name: doc.data()[kUserName],
                  from: doc.data()[kFromUser],
                  statue: doc.data()[kUserStatue],
                  to: doc.data()[kToUser],
                  id: doc.id,
                  photo: doc.data()[kUserPhoto],
                ));
              }
              return ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  // if filter is null or empty returns all data
                  return filter == null || filter == ""
                      ? localId == users[index].id
                          ? Container()
                          : ListTile(
                              title: Text(
                                "${users[index].name}",
                              ),
                              subtitle: Text("${users[index].statue}"),
                              leading: new CircleAvatar(
                                backgroundImage:
                                    NetworkImage(users[index].photo),
                                backgroundColor: Colors.transparent,
                              ),
                              onTap: () {
                                _onTapItem(context, users[index]);
                              },
                            )
                      : users[index]
                              .name
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? localId == users[index].id
                              ? Container()
                              : ListTile(
                                  title: Text(
                                    "${users[index].name}",
                                  ),
                                  subtitle: Text("${users[index].statue}"),
                                  leading: new CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(users[index].photo),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  onTap: () {
                                    _onTapItem(context, users[index]);
                                  })
                          : Container();
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }

  void _onTapItem(BuildContext context, User user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatView(
                  user: user,
                )));
  }
}
