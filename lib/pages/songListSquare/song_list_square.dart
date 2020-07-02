import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/widgets/music_cover_progress.dart';
import 'song_list_square_content.dart';

class SongListSquare extends StatelessWidget {
  static String routerName = '/songListSquare';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歌单广场', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 11.px),
            child: MusicCoverProgress(),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SquareContent(),
    );
  }
}