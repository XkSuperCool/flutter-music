import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/model/playerModel/lyrics_model.dart';
import 'package:flutter_music/servives/player_api.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/extension/num_extension.dart';

class MusicLyrics extends StatefulWidget {
  final int id;

  MusicLyrics(this.id);

  @override
  MusicLyricsState createState() => MusicLyricsState();
}

class MusicLyricsState extends State<MusicLyrics> {
  Map<String, dynamic> _lyrics = {};
  ScrollController _scrollController;
  AudioPlayer _audioPlayer;
  int _currentIndex; // 当前播放到的歌曲列表下标
  int _cacheId; // 缓存的歌曲 id，当播放歌曲的 id 变化时，使用其对比加载新的歌词

  @override
  void initState() {
    _cacheId = widget.id;
    _getLyrics(_cacheId);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _audioPlayer.onAudioPositionChanged.listen((p) {});
    super.dispose();
  }

  //获取歌词信息
  _getLyrics(int id) async {
    Map<String, dynamic> lyrics = {
      'lyric': [],
      'millisecond': []
    };
    LyricsModel res = await PlayerApi.getLyrics(id);
    List<String> lyricArr = res.lyric.split('\n');
    RegExp reg = RegExp(r'\s*\[(\w+:\w+\.\w+)\](\s*[\W\w]+)*');
    for(final item in lyricArr) {
      if (item.trim() != '') {
        var matches = reg.allMatches(item);
        // 没有匹配到，直接添加到歌词数组中，并跳出当次循环
        if (matches.length == 0) {
          lyrics['lyric'].add(item);
          continue;
        }
        var match = matches.elementAt(0);
        // 时间处理，处理为毫秒
        List<String> timeArr = match.group(1).split(':');
        int millisecond = int.parse(timeArr[0]) * 60 * 1000;
        millisecond += int.parse(timeArr[1].split('.')[0]) * 1000;
        millisecond += int.parse(timeArr[1].split('.')[1]);

        lyrics['lyric'].add(match.group(2));
        lyrics['millisecond'].add(millisecond);
      }
    }

    _lyrics = lyrics;
    if (mounted) setState(() {});
  }

  // 播放监听
  _onAudioPositionChanged() async {
     _audioPlayer.onAudioPositionChanged.listen((Duration  p) async {
       // 获取当前播放时间
       int time = await _audioPlayer.getCurrentPosition();
       // 获取储存歌词时间数组长度
       int length = _lyrics['millisecond'] != null ? _lyrics['millisecond'].length : 0;
       if (length == 0) return;

       // 获取对应需要高亮的 index
       for (var i = 0; i < length; i++) {
         if (time >= _lyrics['millisecond'][i] && mounted) {
           _currentIndex = i; // 需要高亮的歌词数组下标 = 当前播放到的时间数组下标
           // 歌词滚动
           _scrollController.animateTo(
             i * 30.px,
             duration: Duration(milliseconds: 500),
             curve: Curves.ease
           );
           setState(() {});
         }
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    // 判断是否改变了播放歌曲
    if (_cacheId != widget.id) {
      _getLyrics(widget.id);
      _cacheId = widget.id;
      _lyrics['lyric'] = [];
    }

    // TODO：首次执行获取全局的 player
    if (_audioPlayer == null) {
      _audioPlayer = Provider.of<MusicViewModel>(context).audioPlayer;
      // 监听事件
      _onAudioPositionChanged();
    }

    // 获取歌词数组
    List<dynamic> lyric =  _lyrics['lyric'] ?? [];

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      itemCount: lyric.length,
      itemBuilder: (ctx, index) => Container(
        height: 30.px,
        child: lyric.length != 0 ? Text(
          lyric[index] ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _currentIndex != index ? Color.fromRGBO(255, 255, 255, .8) : Colors.red,
          ),
        ) : Text('歌词加载中...', style: TextStyle(color: Colors.white)),
      )
    );
  }
}