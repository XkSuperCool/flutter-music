/*
* @descriptor 发现页面网络请求
* @author Ki
*  */

import 'package:flutter_music/model/dscoveryModel/banner_model.dart';
import 'package:flutter_music/model/dscoveryModel/recommend_music_model.dart';
import 'package:flutter_music/model/dscoveryModel/song_list_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class DiscoveryApi {
  // 获取 Banner
  static Future<List<BannerModel>> getBanner() async {
    try {
      final res = (await Http.request('/banner/2'))['banners'];
      List<BannerModel> banners = [];
      for(var item in res) {
        banners.add(
            BannerModel.fromJson(item)
        );
      }
      return banners;
    } catch(e) {
      return [];
    }
  }

  // 获取歌单
  static Future<List<SongListModel>> getSongList({ int count = 6 }) async {
    try {
      final songs = (await Http.request('/personalized?limit=$count'))['result'];
      List<SongListModel> songList = [];

      for(var item in songs) {
        songList.add(
          SongListModel.fromJson(item)
        );
      }

      return songList;
    } catch(e) {
      return [];
    }
  }

  // 获取推荐音乐
  static Future<List<RecommendMusicModel>> getRecommendedMusic() async {
    try {
      final res = (await Http.request('/personalized/newsong'))['result'];
      List<RecommendMusicModel> musicList = [];

      for(var item in res) {
        musicList.add(
          RecommendMusicModel.fromJson(item)
        );
      }

      return musicList;
    } catch(e) {
      return [];
    }
  }
}
