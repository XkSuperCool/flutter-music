import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/pages/hotCommentWall/hot_comment_wall.dart';
import 'package:flutter_music/extension/num_extension.dart';

class CloudSquare extends StatefulWidget {
  @override
  CloudSquareState createState() => CloudSquareState();
}

class CloudSquareState extends State<CloudSquare> {
  Map<int, String> _mapMonth = {
    1: 'Jan.',
    2: 'Feb.',
    3: 'Mar.',
    4: 'Apr.',
    5: 'May.',
    6: 'Jun.',
    7: 'Jul.',
    8: 'Aug.',
    9: 'Sep.',
    10: 'Oct.',
    11: 'Nov.',
    12: 'Dec.'
  };

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildHotCommentWall()
              ]
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                return Container(
                  color: Colors.green,
                  child: Text('$index'),
                );
              }
            ),
          )
        ],
      ),
    );
  }

  // 热评墙
  Widget _buildHotCommentWall() {
    String day = DateTime.now().day > 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(HotCommentWall.routerName);
      },
      child: Container(
        padding: EdgeInsets.all(10.px),
        margin: EdgeInsets.only(bottom: 10.px),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(6.px)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('网易云热评墙 >', style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.px,
                  fontWeight: FontWeight.bold
                )),
                Text('乾坤未定，你我皆是黑马！', style: TextStyle(
                  color: Colors.white,
                ))
              ],
            ),
            Column(
              children: <Widget>[
                Text('${ _mapMonth[DateTime.now().month] }', style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.px,
                  fontWeight: FontWeight.bold
                )),
                Text(day, style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.px,
                  fontWeight: FontWeight.bold
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}