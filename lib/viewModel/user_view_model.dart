import 'package:flutter/cupertino.dart';
import 'package:flutter_music/model/userModel/user_model.dart';

class UserViewModel extends ChangeNotifier {
  UserModel _userInfo;

  UserModel get userInfo => _userInfo;

  set userInfo(UserModel user) {
    _userInfo = user;
    notifyListeners();
  }
}