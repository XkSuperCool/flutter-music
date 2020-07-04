import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_content.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => States();
}

class States extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MyContent(),
    );
  }
}