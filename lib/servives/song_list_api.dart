import 'package:flutter_music/model/dscoveryModel/song_list_model.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';
import 'package:flutter_music/model/songListModel/song_list_item_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class SongListApi {
  // 获取歌单信息
  static Future<SongLisItemModel> getSongListDetail(int id) async {
    final res = (await Http.request('/playlist/detail?id=$id'))['playlist'];
    SongLisItemModel data = SongLisItemModel.fromJson(res);
    return data;
  }

  // 获取歌单下面所有的曲目
  static Future<List<MusicItemModel>> getSongListTracks(String ids) async {
    try {
      final res = (await Http.request('/song/detail?ids=$ids'))['songs'];
      List<MusicItemModel> tracks = [];
      for(final item in res) tracks.add(MusicItemModel.fromJson(item));

      return tracks;
    } catch(e) {
      return null;
    }
  }

  // 根据标签获取歌单列表
  static Future<List<SongListModel>> getSongListByTag(String tag, { int before, int limit = 12}) async {
    final res = (await Http.request(
      '/top/playlist/highquality?cat=$tag&before=${ before ?? '' }&limit=$limit')
    )['playlists'];

    List<SongListModel> list = [];

    for(final item in res) {
      Map<String, dynamic> temp = {
        'id': item['id'],
        'name': item['name'],
        'picUrl': item['coverImgUrl'],
        'playCount': item['playCount'],
        'updateTime': item['updateTime'],
      };
      // TODO： model 不同，多次转换
      list.add(SongListModel.fromJson(temp));
    }

    return list;
  }
}