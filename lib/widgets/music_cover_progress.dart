import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/widgets/rotate_animation.dart';

/*
* 右上角音乐播放封面旋转，圆形进度条
* */

class MusicCoverProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(PlayerPage.routerName),
      child: Consumer<MusicViewModel>(
        builder: (ctx, value, child) {
          return value.currentPlayerMusicItem != null ? Container(
            width: 30.px,
            height: 30.px,
            padding: EdgeInsets.all(1.px),
            margin: EdgeInsets.symmetric(horizontal: 12.px),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  value:  value.progress,
                  strokeWidth: 2.px,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  backgroundColor: Color(0x30cccccc),
                ),
                RotateAnimation(
                  rotate: value.playerState == AudioPlayerState.PLAYING,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      value.currentPlayerMusicItem.al.picUrl,
                      width: 23.px
                    )
                  )
                )
              ],
            ),
          ) : SizedBox(width: 15.px);
        },
      ),
    );
  }
}