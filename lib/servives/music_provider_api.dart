/*
* @descriptor music 的对应请求
* @author Ki
*  */

import 'package:flutter_music/model/musicProviderModel/check_music.dart';
import 'package:flutter_music/model/musicProviderModel/current_music.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class MusicProviderApi {
  /*
  * 检查音乐是否可用
  * id: 音乐 id
  * */
  static Future<CheckMusicModel> checkMusic(int id) async {
    try {
      final res = await Http.request('/check/music?id=$id');
      CheckMusicModel check = CheckMusicModel.fromJson(res);
      return check;
    } catch(e) {
      return null;
    }
  }

  /*
  * 获取播放音乐信息
  * id: 音乐 id
  * */
  static Future<CurrentMusicModel> getPlayMusic(int id) async {
    try {
      final res = (await Http.request('/song/url?id=$id'))['data'][0];
      CurrentMusicModel music = CurrentMusicModel.fromJson(res);
      return music;
    } catch(e) {
      return {} as CurrentMusicModel;
    }
  }

  // 获取音乐详情
  static Future<MusicItemModel> getMusicDetail(int id) async {
    try {
      final res = (await Http.request('/song/detail?ids=$id'))['songs'][0];
      return MusicItemModel.fromJson(res);
    } catch(e) {
      return null;
    }
  }
}