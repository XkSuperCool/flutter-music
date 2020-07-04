import 'dart:ui' show ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/widgets/music_list_item.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/widgets/music_list_app_bar_bottom.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';
import 'package:flutter_music/servives/recommend_song_api.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/widgets/music_list_sliver_app_bar.dart';

class RecommendSongContent extends StatefulWidget {
  @override
  RecommendSongContentState createState() => RecommendSongContentState();
}

class RecommendSongContentState extends State<RecommendSongContent> {
  List<MusicItemModel> _musicList = [];

  @override
  void initState() {
    super.initState();

    // 获取推荐音乐
    RecommendSongApi.getRecommendSongList().then((res) {
      _musicList = res;
      setState(() {});
    });
  }

  // 音乐播放
  _playMusic(MusicViewModel provider, { int index = 0 }) async {
    // 设置音乐歌单
    provider.musicList = _musicList;
    // 播放歌单中点击的音乐
    bool isPlay = await provider.getPlayMusic(_musicList[index]);
    if (isPlay) {
      Navigator.of(context).pushNamed(PlayerPage.routerName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildHeader(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _buildMusicItem(index);
            },
            childCount: _musicList.length,
          ),
        )
      ],
    );
  }

  // Header
  Widget _buildHeader() {
    return Selector<MusicViewModel, MusicViewModel>(
      builder: (ctx, musicProvider, child) {
        return MusicListSliverAppBar(
          expandedHeight: 190.px,
          title: '',
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.px),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 70),
                  _buildDate()
                ],
              )
            ),
          ),
          coverImgUrl: 'https://img.599ku.com/element_pic/69/12/81/67/08610b3bfcfd0680ddcc206b191cd338.jpg',
          bottom: MusicListAppBarBottom(
            counter: _musicList.length,
            onPlayAll: () => _playMusic(musicProvider),
          ),
        );
      },
      selector: (ctx, providerA) => providerA,
      shouldRebuild: (prev, next) => false,
    );
  }

  // 歌曲列表每一项
  Widget _buildMusicItem(int index) {
    if (_musicList.length == 0) return Center(child: CupertinoActivityIndicator(radius: 10.px));

    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child) {
        return GestureDetector(
          onTap: () => _playMusic(musicModel, index: index),
          child: MusicListItem(index, _musicList[index], musicModel.currentPlayerMusicItem?.id),
        );
      }
    );
  }

  // 顶部时间
  Widget _buildDate() {
    DateTime dateTime = DateTime.now();

    return Padding(
      padding: EdgeInsets.only(left: 20.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${ dateTime.day < 10 ? "0" + (dateTime.day).toString() : dateTime.day }',
                  style: TextStyle(
                    fontSize: 40.px,
                    fontWeight: FontWeight.bold,
                  )
                ),
                TextSpan(text: ' / ', style: TextStyle(
                  fontSize: 20.px
                )),
                TextSpan(
                  text: '${ dateTime.month < 10 ? "0" + (dateTime.month).toString() : dateTime.month }',
                  style: TextStyle(
                      fontSize: 20.px
                  ),
                )
              ]
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.px, horizontal: 12.px),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20.px)
            ),
            child: Text('今日推荐', style: TextStyle(
              fontSize: 14.px, color: Colors.black
            )),
          )
        ],
      ),
    );
  }
}