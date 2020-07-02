import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music/widgets/music_header.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

class PlayerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MusicHeader(
      title: _buildMusicInfo(),
      color: Colors.transparent,
      leftWidgetColor: Colors.white,
      rightWidget: IconButton(
        icon: Icon(Icons.share, color: Colors.white),
        onPressed: () => {},
      ),
    );
  }

  // 音乐信息展示
  Widget _buildMusicInfo() {
    return Selector<MusicViewModel, MusicItemModel>(
      builder: (ctx, music, child) {
        // 拼接歌手名 -> xx/xx/xx
        String singers = music.ar.map((item) => item.name).join('/');

        return Column(
          children: <Widget>[
            SizedBox(height: 5.px),
            Text(
              music.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.px,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              singers,
              style: TextStyle(color: Colors.white, fontSize: 12.px),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        );
      },
      selector: (ctx, musicModel) => musicModel.currentPlayerMusicItem,
    );
  }
}