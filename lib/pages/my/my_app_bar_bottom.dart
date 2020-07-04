import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/extension/num_extension.dart';

class AppBarBottom extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.px,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            bottom: -5.px,
            left: 0,
            right: 0,
            child: Container(
              height: 20.px,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.px),
                  topRight: Radius.circular(18.px),
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(20.px);
}