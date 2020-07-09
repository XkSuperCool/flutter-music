import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'hot_comment_wall_content.dart';

class HotCommentWall extends StatelessWidget {
  static String routerName = '/hotCommentWall';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HotCommentWallContent(),
    );
  }
}