import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/pages/hotCommentWall/hot_comment_wall.dart';

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
    return Padding(
      padding: EdgeInsets.only(left: 10.px, top: 10.px, right: 10.px),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            _buildHotCommentWall(),
            StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: 20,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.px),
                  child: Image.network('https://picsum.photos/${ index % 2 == 0 ? 200 : 300 }/${ index / 2 == 0 ? 300 : 200 }?random=$index', fit: BoxFit.cover),
                )
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
            )
          ],
        ),
      ),
    );
  }

  // 热评墙
  Widget _buildHotCommentWall() {
    String day = DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(HotCommentWallPage.routerName);
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