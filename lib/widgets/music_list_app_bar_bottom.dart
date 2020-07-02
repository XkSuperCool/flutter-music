import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/extension/num_extension.dart';

class MusicListAppBarBottom extends StatelessWidget with PreferredSizeWidget {
  final int counter;
  final Function onPlayAll;

  MusicListAppBarBottom(this.counter, { this.onPlayAll });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: onPlayAll,
            child: _buildPlayAll(),
          )
        ],
      ),
    );
  }

  _buildPlayAll() {
    return Row(
      children: <Widget>[
        Icon(Icons.play_circle_outline),
        SizedBox(width: 10.px),
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                // 基线对齐
                alignment: PlaceholderAlignment.middle,
                child: Text('播放全部', style: TextStyle(
                  fontSize: 16.px,
                  fontWeight: FontWeight.bold
                ))
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  '(共 $counter 首)',
                  style: TextStyle(fontSize: 15.px, color: Colors.grey)
                ),
              )
            ]
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.px);
}