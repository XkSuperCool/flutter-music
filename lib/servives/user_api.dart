import 'package:flutter_music/model/userModel/user_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class UserApi {
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
}