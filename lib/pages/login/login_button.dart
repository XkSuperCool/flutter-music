import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final Function clickEvent;

  LoginButton(this.title, { this.textColor, this.color, this.clickEvent });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: FlatButton(
        color: color,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white)
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(title, style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )),
        onPressed: clickEvent ?? () => {}
      ),
    );
  }
}