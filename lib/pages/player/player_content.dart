import 'dart:ui' show  ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'player_header.dart';
import 'player_music.dart';
import 'player_music_controller.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

class MusicContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildCover(),
        _buildMusicContainer(),
      ],
    );
  }

  // 底部封面图
  Widget _buildCover() {
    return Selector<MusicViewModel, MusicItemModel>(
      builder: (ctx, music, child) {
        return Transform.scale(
          scale: 2,
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.network(
              music.al.picUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      selector: (ctx, musicModel) => musicModel.currentPlayerMusicItem,
    );
  }

  // 主体内容布局
  Widget _buildMusicContainer() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black38,
      child: Column(
        children: <Widget>[
          PlayerHeader(),
          Expanded(
            child: PlayerMusic(),
          ),
          MusicController()
        ],
      )
      ),
    );
  }
}