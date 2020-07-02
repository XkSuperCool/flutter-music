import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_content.dart';

class LoginPage extends StatelessWidget {
  static String routerName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginContent(),
    );
  }
}