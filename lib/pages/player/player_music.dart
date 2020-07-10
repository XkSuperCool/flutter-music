import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  int _currentMusicIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child) {
        int curIndex = musicModel.musicList.indexWhere((item) => item.id == musicModel.currentPlayerMusicItem.id);
        return Swiper(
          itemBuilder: (ctx, idx) => Center(
            child: GestureDetector(
              onTap: () async {
                isShowLyrics = !isShowLyrics;
                setState(() {});
              },
              child: isShowLyrics ? Padding(
                padding: EdgeInsets.only(top: 10),
                child: MusicLyrics(musicModel.currentPlayerMusicItem.id),
              ) : _buildCover(musicModel, curIndex),
            )
          ),
          itemCount: musicModel.musicList.length,
          onIndexChanged: (index) async {
            int playIndex;
            int length = musicModel.musicList.length;
            final musicList = musicModel.musicList;

            if (index - _currentMusicIndex == 1 && curIndex != length - 1) {
              playIndex = curIndex + 1;
            } else if (index - _currentMusicIndex == -1 && curIndex != 0) {
              playIndex = curIndex - 1;
            } else if (index == length - 1 || (index - _currentMusicIndex == -1 && curIndex == 0)) {
              if (curIndex != 0) {
                playIndex = curIndex - 1;
              } else {
                playIndex = length - 1;
              }
            } else {
              playIndex = 0;
            }
            await musicModel.getPlayMusic(musicList[playIndex]);
            _currentMusicIndex = index;
          },
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
        child: Container(
          width: 230.px,
          height: 230.px,
          child: Image.network(
            music.musicList[index].al.picUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
