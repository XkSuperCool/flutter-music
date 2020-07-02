import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'player_content.dart';

class PlayerPage extends StatelessWidget {
  static final String routerName = '/play';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MusicContent(),
    );
  }
}