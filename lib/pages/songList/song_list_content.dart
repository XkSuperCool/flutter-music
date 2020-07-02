import 'dart:ui' show  ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'song_list_info.dart';
import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/servives/song_list_api.dart';
import 'package:flutter_music/widgets/music_list_item.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/widgets/music_list_app_bar_bottom.dart';
import 'package:flutter_music/widgets/music_list_sliver_app_bar.dart';
import 'package:flutter_music/model/songListModel/song_list_item_model.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

class SongListContent extends StatefulWidget {
  final int songListId;

  SongListContent(this.songListId);

  @override
  SongListContentState createState() => SongListContentState();
}

class SongListContentState extends State<SongListContent> {
  SongLisItemModel _songDetail;
  List<MusicItemModel> _tracks = [];

  @override
  void initState() {
    super.initState();
    SongListApi.getSongListDetail(widget.songListId).then((res) async {
      _songDetail = res;
      // 获取歌单下面所有的曲目
      _tracks = await SongListApi.getSongListTracks(
        res.trackIds.map((i) => i.id).join(',')
      );
      setState(() {});
    });
  }

  // 音乐播放
  _playMusic(MusicViewModel musicModel, { int index = 0 }) async {
    // 设置音乐歌单
    musicModel.musicList = _tracks;
    // 播放歌单中点击的音乐
    bool isPlay = await musicModel.getPlayMusic(_tracks[index]);
    if (isPlay) {
      Navigator.of(context).pushNamed(PlayerPage.routerName);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_tracks.length == 0) {
      return Center(
        child: CupertinoActivityIndicator(radius: 15.px)
      );
    }

    return CustomScrollView(
      slivers: <Widget>[
        _buildHeader(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _buildMusicItem(index);
            },
            childCount: _tracks.length,
          ),
        )
      ],
    );
  }

  // Header
  Widget _buildHeader() {
    return Selector<MusicViewModel, MusicViewModel>(
      builder: (ctx, musicModel, child) {
        return MusicListSliverAppBar(
          expandedHeight: 250.px,
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.px),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70),
                  SongListInfo(_songDetail)
                ],
              )
            ),
          ),
          coverImgUrl: _songDetail.coverImgUrl,
          bottom: MusicListAppBarBottom(
            _songDetail.trackCount,
            onPlayAll: () => _playMusic(musicModel),
          ),
        );
      },
      selector: (ctx, musicModel) => musicModel,
      shouldRebuild: (prev, next) => false,
    );
  }

  // 歌曲列表每一项
  Widget _buildMusicItem(int index) {
    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child) {
        return GestureDetector(
          onTap: () => _playMusic(musicModel, index: index),
          child: MusicListItem(index, _tracks[index], musicModel.currentPlayerMusicItem?.id),
        );
      }
    );
  }
}
