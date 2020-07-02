import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/dscoveryModel/song_list_model.dart';
import 'package:flutter_music/utils/util.dart' show formatCounter;

class MusicCard extends StatelessWidget {
  final SongListModel musicInfo;
  MusicCard({ this.musicInfo });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.px,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6.px),
                child: Image.network(
                  musicInfo.picUrl,
                  height: 110.px,
                  width: 110.px,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: _buildPlayerCount(),
              )
            ],
          ),
          Text(
            musicInfo.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _buildPlayerCount() {
    String playCount = musicInfo.playCount.toString();
    String count;
    // 处理播放量
    count = formatCounter(int.parse(playCount));
    return Row(
      children: <Widget>[
        Icon(Icons.play_arrow, color: Colors.white, size: 14.px),
        SizedBox(width: 3.px),
        Text(
          count,
          style: TextStyle(
            color: Colors.white
          )
        )
      ],
    );
  }
}