import 'package:flutter_music/model/cloudModel/friends_news_model.dart';
import 'package:flutter_music/model/cloudModel/hot_comment_model.dart';
import 'package:flutter_music/model/cloudModel/user_attention_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class CloudApi {
  // 获取云村热评
  static Future<List<HotCommentModel>> getHotComment() async {
    try {
      final res = (await Http.request('/comment/hotwall/list'))['data'];
      List<HotCommentModel> list = [];
      for(final item in res) list.add(HotCommentModel.fromJson(item));
      return list;
    } catch(e) {
      return [];
    }
  }

  // 获取朋友动态
  static Future<FriendsNewsModel> getFriendsNews({ int pagesize = 10, int lasttime }) async {
    try {
      final res = await Http.request('/event?pagesize=$pagesize&lasttime=${ lasttime ?? '' }');
      FriendsNewsModel friendsNews = FriendsNewsModel.fromJson(res);
      return friendsNews;
    } catch(e) {
      return null;
    }
  }
  
  // 获取用户关注列表
  static getUserAttentions(int uid) async {
    final res = (await Http.request('/user/follows?uid=$uid'))['follow'];
    List<UserAttentionModel> list = [];
    for(final item in res) list.add(UserAttentionModel.fromJson(item));

    return list;
  }
}