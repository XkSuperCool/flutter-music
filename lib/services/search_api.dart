import 'package:flutter_music/model/searchModel/hot_search.dart';
import 'package:flutter_music/model/searchModel/search_song_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class SearchApi {
  static Future<List<HotSearchModel>> getHotSearch() async {
    final res = (await Http.request('/search/hot/detail'))['data'];
    List<HotSearchModel> list = [];
    for(final item in res) list.add(HotSearchModel.fromJson(item));

    return list;
  }

  static Future<List<SearchSongModel>> getSongListByKey(String keywords, { int offset = 0 }) async {
    try {
      final res = (await Http.request('/search?keywords=$keywords&offset=$offset'))['result']['songs'];
      List<SearchSongModel> list = [];
      for(final item in res) list.add(SearchSongModel.fromJson(item));
      return list;
    } catch(e) {
      return [];
    }
  }
}