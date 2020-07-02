import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/pages/songList/song_list.dart';
import 'package:flutter_music/pages/songListSquare/song_list_square.dart';

import 'package:flutter_music/widgets/music_card.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/dscoveryModel/song_list_model.dart';
import 'package:flutter_music/widgets/click_animation.dart';

import 'discovery_title.dart';

class SongList extends StatelessWidget {
  final List<SongListModel> list;
  final String songListName;

  SongList(this.songListName, { this.list });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DiscoveryTitle(songListName,
          rightBtn: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(SongListSquare.routerName),
            child: Text('查看更多')
          ),
        ),
        Container(
          width: double.infinity,
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (ctx, index) => _buildSongCard(index, context),
          ),
        ),
      ],
    );
  }

  Widget _buildSongCard(int index, BuildContext context) {
    // 使用自定义动画组件 ClickAnimation 添加点击动画
    return ClickAnimation(
      child: Container(
        margin: EdgeInsets.only(
          left: index == 0 ? 15.px : 8.px,
          right: index == list.length - 1 ? 15.px : 0
        ),
        child: MusicCard(musicInfo: list[index]),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        SongListPage.routerName,
        arguments: list[index].id
      ),
    );
  }
}
