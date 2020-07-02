import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primaryColor: Color.fromRGBO(226, 0, 0, 1),
  tabBarTheme: TabBarTheme(
    labelColor: Color.fromRGBO(226, 0, 0, 1),
    unselectedLabelColor: Colors.black,
    indicator: BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(color: Color.fromRGBO(226, 0, 0, 1), width: 2)
      ),
    ),
    labelStyle: TextStyle(
      fontSize: 15
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 15
    ),
  )
);

