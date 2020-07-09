import 'package:flutter_music/model/cloudModel/hot_comment_model.dart';
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
}