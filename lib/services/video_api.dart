import 'package:flutter_music/model/videoModel/video_category_model.dart';
import 'package:flutter_music/model/videoModel/video_list_item.dart';
import 'package:flutter_music/utils/http_request.dart';

class VideoApi {
  // 分类
  static Future<List<VideoCategory>> getVideoCategoryList() async {
    try {
      final res = (await Http.request('/video/category/list'))['data'];
      List<VideoCategory> list = [];
      for(final item in res) list.add(VideoCategory.fromJson(item));
      return list;
    } catch(e) {
      return [];
    }
  }
  
  // 获取分类下的视频列表
  static Future<List<VideoListItem>> getVideoList(int id, { int offset = 0 }) async {
    try {
      final res = (await Http.request('/video/group?id=$id&offset=$offset'))['datas'];
      List<VideoListItem> list = [];
      for(final item in res) list.add(VideoListItem.fromJson(item['data']));
      return list;
    } catch(e) {
      return [];
    }
  }

  // 获取播放地址
  static Future<String> getVideoUrl(String id) async {
    final res = (await Http.request('/video/url?id=$id'))['urls'][0];
    return res['url'];
  }
}