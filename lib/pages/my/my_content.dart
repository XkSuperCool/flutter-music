import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlineButton(
        child: Text('login'),
        onPressed: () => Navigator.of(context).pushNamed('/login'),
      ),
    );
  }
}