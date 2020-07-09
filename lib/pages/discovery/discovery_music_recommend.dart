import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/dscoveryModel/recommend_music_model.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';
import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/services/music_provider_api.dart';
import 'package:flutter_music/services/song_list_api.dart';
import 'package:provider/provider.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/widgets/click_animation.dart';

import 'discovery_title.dart';

class MusicRecommend extends StatefulWidget {
  final List<RecommendMusicModel>  _list;

  MusicRecommend(this._list);

  @override
  MusicRecommendState createState() => MusicRecommendState();
}

class MusicRecommendState extends State<MusicRecommend> {
  PageController _pageController;

  // 获取 _list 里面所有歌曲的信息
  Future<List<MusicItemModel>> _getMusicInfoAll() async {
    // 获取音乐列表所有音乐的 id 组成一个字符串
    String ids = widget._list.map((i) => i.id).join(',');
    // 获取所有歌曲的信息数组
    List<MusicItemModel> musicList = await SongListApi.getSongListTracks(ids);
    return musicList;
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: .92,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._list.length == 0) return SizedBox();

    return Column(
      children: <Widget>[
        _buildTitle(),
        Container(
          height: 230,
          alignment: Alignment.centerLeft,
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              _buildMusicColumn(widget._list.sublist(0, 3)),
              _buildMusicColumn(widget._list.sublist(3, 6)),
              _buildMusicColumn(widget._list.sublist(6, 9)),
            ],
          ),
        )
      ],
    );
  }

  // 头部 title
  Widget _buildTitle() {
    return Selector<MusicViewModel, MusicViewModel>(
      builder: (ctx, musicModel, child) {
        return DiscoveryTitle('推荐新音乐',
          rightBtn: GestureDetector(
            onTap: () async {
              List<MusicItemModel> musicList = await _getMusicInfoAll();
              // 设置播放歌曲列表
              musicModel.musicList = musicList;
              // 播放第一首
              bool isPlay = await musicModel.getPlayMusic(musicList[0]);
              // 跳转播放页
              if (isPlay) Navigator.of(ctx).pushNamed(PlayerPage.routerName);
            },
            child: child,
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Icon(Icons.play_arrow, size: 18.px),
          Text('播放全部')
        ],
      ),
      selector: (ctx, musicModel) => musicModel,
      shouldRebuild: (previous, next) => false,
    );
  }

  // 每一列
  Widget _buildMusicColumn(List<RecommendMusicModel> music) {
    return Container(
      margin: EdgeInsets.only(left: 3.px),
      child: Column(
        children: <Widget>[
          _buildMusicItem(music[0]),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.px),
            child: _buildMusicItem(music[1]),
          ),
          _buildMusicItem(music[2]),
        ],
      ),
    );
  }

  // 音乐项
  Widget _buildMusicItem(RecommendMusicModel musicItem) {
    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child) {
        return ClickAnimation(
          onTap: () async {
            // TODO: flag -> 当前歌曲处于未播放状态时点击触发播放，如果是播放状态时点击跳转 player 页面
            bool flag = false;
            if(musicModel.currentPlayerMusicItem?.id == musicItem.id) flag = true;

            // 获取当前点击的音乐详情
            MusicItemModel detail = await MusicProviderApi.getMusicDetail(musicItem.id);
            bool isPlayer = await musicModel.getPlayMusic(detail);
            // 获取所音乐详情信息
            List<MusicItemModel> musicList = await _getMusicInfoAll();
            // 设置播放歌曲列表
            musicModel.musicList = musicList;
            if (isPlayer && flag) Navigator.of(ctx).pushNamed(PlayerPage.routerName);
          },
          child: child,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildMusicCover(musicItem),
          SizedBox(width: 10.px),
          Expanded(
            child: _buildMusicInfo(musicItem),
          ),
          _buildMusicPlayButton(musicItem.id),
          SizedBox(width: 10.px)
        ],
      ),
    );
  }

  // 右侧音乐控制按钮
  Widget _buildMusicPlayButton(int id) {
    return Selector<MusicViewModel, int>(
      builder: (ctx, musicId, child) {
        // 当前音乐处于播放时为 music_play，未播放时为 music_pause
        String path = musicId == id ? 'assets/images/home/music_player.png' : 'assets/images/home/music_pause.png';
        return Image.asset(path, width: 28.px);
      },
      selector: (ctx, musicModel) => musicModel.currentPlayerMusicItem?.id,
    );
  }

  // 封面图片
  Widget _buildMusicCover(RecommendMusicModel musicItem) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.px),
      child: Image.network(
        musicItem.picUrl,
        width: 60.px,
        height: 60.px,
      ),
    );
  }

  // 中间音乐描述
  Widget _buildMusicInfo(RecommendMusicModel musicItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMusicName(musicItem),
        SizedBox(height: 5.px),
        _buildMusicDesc(musicItem)
      ],
    );
  }

  // 歌曲名称
  Widget _buildMusicName(RecommendMusicModel musicItem) {
    // 音乐作者列表处理
    List<String> artists = musicItem.song.artists.map((item) => item.name).toList();
    String names = artists.length > 3 ? artists.sublist(0, 3).join(',') : artists.join('.');

    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              '${ musicItem.name } ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16)
            )
          ),
          WidgetSpan(
            child: Text(
              names,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color.fromRGBO(160, 160, 160, 1)
              )
            )
          ),
        ]
      ),
    );
  }

  // 音乐描述
  Widget _buildMusicDesc(RecommendMusicModel musicItem) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.px, horizontal: 5.px),
          margin: EdgeInsets.only(right: 5.px),
          decoration: BoxDecoration(
            color: Color.fromRGBO(254, 225, 223, 1),
            borderRadius: BorderRadius.circular(5.px)
          ),
          child: Text('推荐',
            style: TextStyle(
              color: Colors.red,
              fontSize: 11.px
            )
          )
        ),
        Expanded(
          child: Text(musicItem.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color.fromRGBO(160, 160, 160, 1)
            )
          ),
        )
      ],
    );
  }
}