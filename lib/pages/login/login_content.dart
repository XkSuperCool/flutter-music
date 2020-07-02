import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/pages/main/main.dart';
import 'login_tel.dart';
import 'login_button.dart';

class LoginContent extends StatefulWidget {
  @override
  LoginContentState createState() => LoginContentState();
}

class LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: MediaQuery.of(context).size.height / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginButton(
                '手机号登录',
                textColor: Colors.red,
                color: Colors.white,
                clickEvent: () => showGeneralDialog(
                  context: context,
                  barrierDismissible:true,
                  barrierLabel: '',
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return LoginTel();
                  }
                )
              ),
              SizedBox(height: 10),
              LoginButton(
                '立即体验',
                textColor: Colors.white,
                color: Colors.transparent,
                clickEvent: () => Navigator.of(context).pushNamed(MainPage.routerName)
              ),
            ],
          ),
        )
      ],
    );
  }
}