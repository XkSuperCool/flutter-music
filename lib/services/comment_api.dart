import 'package:flutter_music/model/commentModel/comment_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class CommentApi {
  // 获取热评
  static Future<CommentModel> getHotComment(int id) async {
    try {
      final res = await Http.request('/comment/music?id=$id');
      CommentModel comment = CommentModel.fromJson(res);
      return comment;
    } catch(e) {
      return null;
    }
  }
}