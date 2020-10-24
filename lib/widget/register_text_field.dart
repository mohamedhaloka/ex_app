import 'package:ex/const.dart';
import 'package:flutter/material.dart';

class RegisterTextField extends StatefulWidget {
  RegisterTextField(
      {@required this.onSaved,
      @required this.tittle,
      @required this.hintTittle,
      this.controller});
  String tittle;
  Function onSaved;
  String hintTittle;
  TextEditingController controller;
  @override
  _RegisterTextFieldState createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  bool obscure = true;
  errorMessage(tittle) {
    switch (tittle) {
      case 'name':
        return 'Name Field Required*';
      case 'email':
        return 'Email Field Required*';
      case 'password':
        return 'Password Field Required*';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.tittle}".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[600]),
        ),
        TextFormField(
          validator: (val) {
            if (val.isEmpty) {
              return errorMessage(widget.tittle);
            }
            return null;
          },
          maxLines: 1,
          obscureText: widget.tittle == "password" ? obscure : false,
          controller: widget.controller == null ? null : widget.controller,
          onSaved: widget.onSaved,
          cursorColor: accentColor,
          decoration: InputDecoration(
              suffixIcon: widget.tittle == "password"
                  ? IconButton(
                      icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      })
                  : null,
              hintText: widget.hintTittle,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.3)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey[800])),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: accentColor)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.red[900])),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.red[900]))),
        ),
      ],
    );
  }
}
