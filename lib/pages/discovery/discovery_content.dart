import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/model/dscoveryModel/recommend_music_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_music/widgets/music_header.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/servives/discovery_api.dart';
import 'package:flutter_music/model/dscoveryModel/banner_model.dart';
import 'package:flutter_music/model/dscoveryModel/song_list_model.dart';
import 'discovery_music_recommend.dart';
import 'discovery_nav.dart';
import 'discovery_song_list.dart';

class DiscoveryContent extends StatefulWidget {
  @override
  DiscoveryContentState createState() => DiscoveryContentState();
}

class DiscoveryContentState extends State<DiscoveryContent> {
  List<BannerModel> _banner = [];
  List<SongListModel> _songList = [];
  List<RecommendMusicModel> _recommendedMusics = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // 初始化数据
  _initData() async {
    List<dynamic> res = await Future.wait<dynamic>([
      DiscoveryApi.getBanner(), // 获取轮播图
      DiscoveryApi.getSongList(count: 12), // 加载首页歌单
      DiscoveryApi.getRecommendedMusic(), // 获取推荐新音乐
    ]);

    _banner = res[0];
    _songList = res[1];
    _recommendedMusics = res[2];
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40.px),
          child: ListView(
            children: <Widget>[
              _buildSwiper(),
              Nav(),
              SongList('人气歌单推荐', list: _songList.length > 0 ? _songList.sublist(0, 6) : []),
              SongList('宝藏歌单，值得聆听', list: _songList.length > 0 ? _songList.sublist(6, 12) : []),
              MusicRecommend(_recommendedMusics)
            ],
          ),
        ),
        // 顶部控件
        MusicHeader(
          leftWidget: IconButton(
            icon: Icon(
              IconData(0xe74b, fontFamily: 'iconfont'),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  // 轮播图
  _buildSwiper() {
    return Container(
      height: 160.px,
      padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 10.px),
      child: _banner.length > 0 ? Swiper(
        autoplay: true,
        itemCount: _banner.length,
        pagination: SwiperPagination(),
        controller: SwiperController(),
        itemBuilder: (ctx, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(6.px),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  _banner[index].imageUrl,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.px, horizontal: 10.px),
                    decoration: BoxDecoration(
                      color: _banner[index].titleColor == 'blue' ? Colors.blue : Colors.red,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6.px))
                    ),
                    child: Text(
                      _banner[index].typeTitle,
                      style: TextStyle(color: Colors.white, fontSize: 12.px)
                    ),
                  ),
                )
              ],
            )
          );
        },
      ) : null,
    );
  }
}
