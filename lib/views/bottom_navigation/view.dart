import 'package:ex/views/add_friends/view.dart';
import 'package:ex/views/bottom_navigation/bottom_bar_style.dart';
import 'package:ex/views/bottom_navigation/pages/account/view.dart';
import 'package:ex/views/bottom_navigation/pages/users_chat/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../../const.dart';

class BottomNavigationBarView extends StatefulWidget {
  @override
  _BottomNavigationBarViewState createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int _selectedItemPosition = 0;
  List<Widget> pages = [UsersChatView(), AccountView()];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black26,
        bottomNavigationBar: SnakeNavigationBar(
          style: BottomBarStyle().snakeBarStyle,
          snakeShape: BottomBarStyle().snakeShape,
          snakeColor: BottomBarStyle().selectionColor,
          backgroundColor: BottomBarStyle().backgroundColor,
          showUnselectedLabels: BottomBarStyle().showUnselectedLabels,
          showSelectedLabels: BottomBarStyle().showSelectedLabels,
          currentIndex: _selectedItemPosition,
          onPositionChanged: (index) =>
              setState(() => _selectedItemPosition = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
        floatingActionButton: _selectedItemPosition == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddFriendView()));
                },
                child: Icon(Icons.add),
                tooltip: "Add Friend",
              )
            : null,
        body: pages.elementAt(_selectedItemPosition),
      ),
    );
  }
}
