import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_music/model/userModel/user_model.dart';

class UserViewModel extends ChangeNotifier {
  bool _isLogin = false;
  UserModel _userInfo;

  UserViewModel() {
    SharedPreferences.getInstance().then((prefs) {
      final userInfo = prefs.get('userInfo');
      if (userInfo != null) {
        _isLogin = true;
        _userInfo = UserModel.fromJson(convert.jsonDecode(userInfo));
        notifyListeners();
      }
    });
  }

  bool get isLogin => _isLogin;

  set isLogin(bool boolean) {
    _isLogin = boolean;
    notifyListeners();
  }

  UserModel get userInfo => _userInfo;

  set userInfo(UserModel userInfo) {
    _userInfo = userInfo;
    _isLogin = true;
    notifyListeners();
  }
}