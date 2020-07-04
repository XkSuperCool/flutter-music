import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/widgets/click_animation.dart';

class MusicBox extends StatelessWidget {
  final String title;
  final String desc;
  final backgroundImgUrl;
  final Function onTap;

  MusicBox({ @required this.title, @required this.backgroundImgUrl, this.desc, this.onTap });

  @override
  Widget build(BuildContext context) {
    return ClickAnimation(
      onTap: onTap,
      child: Container(
        width: 180.px,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.px),
              child: Container(
                width: 60.px,
                height: 60.px,
                child: Image.network(backgroundImgUrl, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 10.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title ?? '',
                    style: TextStyle(
                      fontSize: 13.px,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(desc ?? '', style: TextStyle(
                    fontSize: 12.px,
                    color: Colors.grey
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}