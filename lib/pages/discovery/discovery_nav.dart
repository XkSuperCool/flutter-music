import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/pages/recommendSong/recommend_song.dart';
import 'package:flutter_music/pages/songListSquare/song_list_square.dart';

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _buildNavList(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildNavList(context),
      )
    );
  }

  // NavList
  List<Widget> _buildNavList(BuildContext context) {
    // 所需的图片、title 集合
    List<String> paths = ['icon_daily', 'icon_playlist', 'icon_rank', 'icon_radio', 'icon_look'];
    List<String> titles = ['每日推荐', '歌单', '排行榜', '电台', '直播'];
    List<Widget> list = [];
    for(int i = 0; i < paths.length; i++) {
      list.add(
        _buildNavItem(context, paths[i], titles[i])
      );
    }

    return list;
  }

  // 每一项 Nav
  Widget _buildNavItem(BuildContext context, String imgPath, String title) {
    return GestureDetector(
      onTap: () => _clickNavItem(title, context),
      child: Column(
        children: <Widget>[
          Container(
            width: 45.px,
            margin: EdgeInsets.only(bottom: 6.px),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset('assets/images/home/$imgPath.png'),
                // TODO: 只有在每日推荐才显示该控件，该控件显示当前日期
                title == '每日推荐' ? Positioned(
                  top: 18.px,
                  child: Text(_getDay(), style: TextStyle(color: Theme.of(context).primaryColor)),
                ) : SizedBox()
              ],
            ),
          ),
          Text(title)
        ],
      ),
    );
  }

  // 点击不同 nav 进行不同处理
  _clickNavItem(String title, BuildContext context) {
    switch(title) {
      case '歌单' : Navigator.of(context).pushNamed(SongListSquare.routerName); break;
      case '每日推荐': Navigator.of(context).pushNamed(RecommendSongPage.routerName); break;
    }
  }

  // 获取当前天
  _getDay() {
    return DateTime.now().day.toString();
  }
}