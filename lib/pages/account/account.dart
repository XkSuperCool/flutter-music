import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account_content.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      body: AccountContent(),
    );
  }
}