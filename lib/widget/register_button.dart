import 'package:ex/const.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton(
      {@required this.function,
      @required this.border,
      @required this.child,
      @required this.fillColors});
  Widget child;
  Function function;
  Color border;
  List<Color> fillColors;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: customWidth(context, 1),
      height: 60,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: fillColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror),
          border: Border.all(
              color: border, width: border == Colors.transparent ? 0 : 2),
          borderRadius: BorderRadius.circular(4)),
      child: RaisedButton(
        onPressed: function,
        elevation: 0.0,
        highlightElevation: 0.0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: child,
      ),
    );
  }
}
