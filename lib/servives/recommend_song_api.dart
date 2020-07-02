import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class RecommendSongApi {
  // 获取每日推荐音乐
  static Future<List<MusicItemModel>> getRecommendSongList() async {
    try {
      final res = (await Http.request('/recommend/songs'))['data']['dailySongs'];
      List<MusicItemModel> list = [];
      for(final item in res) list.add(MusicItemModel.fromJson(item));

      return list;
    } catch(e) {
      return [];
    }
  }
}