import 'dart:ui' show  ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'song_list_info.dart';
import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/services/song_list_api.dart';
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
  int _frequency; // 次数，表示一共可以发送多少次请求获取歌曲信息
  int _counter = 10; // 每次请求数量
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    SongListApi.getSongListDetail(widget.songListId).then((res) async {
      _songDetail = res;
      _frequency = res.trackIds.length ~/ _counter;
      // 获取歌单下面的曲目
      _getSongListTracks();
    });
  }

  // 获取歌曲
  Future<bool> _getSongListTracks() async {
    List<MusicItemModel> tracks = [];
    if (_frequency != 0) {
      tracks = await SongListApi.getSongListTracks(
        _songDetail.trackIds.sublist(0, _counter).map((i) => i.id).join(',')
      );
      _songDetail.trackIds.removeRange(0, _counter); // 减去已经请求过的数据
      _frequency--; // 每发送一次请求，数量减一次
    } else if (_songDetail.trackIds.length != 0 ) {
      tracks = await SongListApi.getSongListTracks(
        _songDetail.trackIds.map((i) => i.id).join(',')
      );
      _songDetail.trackIds.removeRange(0, _songDetail.trackIds.length); // 减去已经请求过的数据
    } else {
      return false;
    }

    _tracks.addAll(tracks);
    if (mounted) setState(() {});
    return true;
  }

  // 上拉加载
  _onLoading() async {
    bool isFalse = await _getSongListTracks();
    if (!isFalse) {
      _refreshController.loadNoData();
      return;
    }
    _refreshController.loadComplete();
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

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: _onLoading,
      child: CustomScrollView(
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
      ),
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
                  SizedBox(height: 62.px),
                  SongListInfo(_songDetail)
                ],
              )
            ),
          ),
          coverImgUrl: _songDetail.coverImgUrl,
          bottom: MusicListAppBarBottom(
            counter: _songDetail.trackCount,
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
