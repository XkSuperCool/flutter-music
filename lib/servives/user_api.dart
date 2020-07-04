import 'package:flutter_music/model/userModel/user_model.dart';
import 'package:flutter_music/model/userModel/user_song_list_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class UserApi {
  // 登录
  static Future<UserModel> login({ String phone, String password}) async {
    try {
      final res = await Http.request('/login/cellphone',
        method: 'post',
        data: {
          'phone': phone,
          'password': password
        }
      );
      UserModel user = UserModel.fromJson(res);
      return user;
    } catch (e) {
      return null;
    }
  }
  
  // 获取用户歌单
  static Future<List<UserSongListModel>> getUserSongList(int uid) async {
    final res = (await Http.request('/user/playlist?uid=$uid'))['playlist'];
    final List<UserSongListModel> list = [];
    for(final item in res) list.add(UserSongListModel.fromJson(item));
    return list;
  }
}