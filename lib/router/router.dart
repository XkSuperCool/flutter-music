import 'package:flutter/cupertino.dart';
import 'package:flutter_music/pages/main/main.dart';

import 'package:flutter_music/pages/login/login.dart';
import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/pages/search/search.dart';
import 'package:flutter_music/pages/songList/song_list.dart';
import 'package:flutter_music/pages/recommendSong/recommend_song.dart';
import 'package:flutter_music/pages/songListSquare/song_list_square.dart';
import 'package:flutter_music/pages/hotCommentWall/hot_comment_wall.dart';

class Router {
  static Map<String, WidgetBuilder> routers = {
    MainPage.routerName: (context) => MainPage(),
    PlayerPage.routerName: (context) => PlayerPage(),
    SongListPage.routerName: (context) => SongListPage(),
    SongListSquare.routerName: (context) => SongListSquare(),
    LoginPage.routerName: (context) => LoginPage(),
    RecommendSongPage.routerName: (context) => RecommendSongPage(),
    HotCommentWallPage.routerName: (context) => HotCommentWallPage(),
    SearchPage.routerName: (context) => SearchPage()
  };
}