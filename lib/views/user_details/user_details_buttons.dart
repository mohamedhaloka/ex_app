import 'package:flutter/material.dart';

class UserDetailsButton extends StatelessWidget {
  UserDetailsButton(
      {@required this.tittle, @required this.icon, @required this.onTap});
  String tittle;
  IconData icon;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.red[900],
        ),
        title: Text(
          "$tittle",
          style: TextStyle(color: Colors.red[900]),
        ),
        onTap: onTap,
      ),
    );
  }
}
