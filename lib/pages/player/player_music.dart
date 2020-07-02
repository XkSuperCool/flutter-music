import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/widgets/rotate_animation.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'player_music_lyrics.dart';

class PlayerMusic extends StatefulWidget {
  @override
  PlayerMusicState createState() => PlayerMusicState();
}

class PlayerMusicState extends State<PlayerMusic> {
  bool isShowLyrics = false; // 是否显示歌词

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child) {
        int index = musicModel.musicList.indexWhere((item) => item.id == musicModel.currentPlayerMusicItem.id);
        return Center(
          child: GestureDetector(
            onTap: () async {
              isShowLyrics = !isShowLyrics;
              setState(() {});
            },
            child: isShowLyrics ? Padding(
              padding: EdgeInsets.only(top: 10),
              child: MusicLyrics(musicModel.currentPlayerMusicItem.id),
            ) : _buildCover(musicModel, index),
          )
        );
      },
    );
  }

  // 封面 + 旋转动画
  Widget _buildCover(MusicViewModel music, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(200.px),
      child: RotateAnimation(
        rotate: music.playerState == AudioPlayerState.PLAYING,
        child: Image.network(
          music.musicList[index].al.picUrl,
          width: 230.px,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
