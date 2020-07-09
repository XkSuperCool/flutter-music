import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_music/services/user_api.dart';
import 'package:flutter_music/pages/main/main.dart';
import 'package:flutter_music/viewModel/user_view_model.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/userModel/user_model.dart';

import 'login_button.dart';

class LoginTel extends StatefulWidget {
  @override
  LoginTelState createState() => LoginTelState();
}

class LoginTelState extends State<LoginTel> {

  TextEditingController _telController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _telController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _telController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 登录方法
  Future<UserModel> handleLogin() async {
    String phone = _telController.value.text;
    String password = _passwordController.value.text;
    UserModel res = await UserApi.login(phone: phone, password: password);
    // 登录错误提示
    if (res == null) {
      return showDialog(
        context: context,
        child: AlertDialog(
          content: Text('请核实账号密码，重新登录'),
          actions: <Widget>[
            FlatButton(
              child: Text('确认'),
              onPressed: () => Navigator.of(context).pop()
            )
          ],
        )
      );
    }
    // cookie 本地保存
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cookie', res.cookie);
    prefs.setString('userInfo', convert.jsonEncode(res));

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('手机号登录'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20.px),
                child: Text('未注册手机号登录后好像是会自动创建账号',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey)
                ),
              ),
              _buildInput(
                hintText: '输入手机号',
                controller: _telController,
                isShowIcon: true,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.px),
                child: _buildInput(
                  hintText: '输入密码',
                  controller: _passwordController,
                  obscureText: true
                ),
              ),
              Consumer<UserViewModel>(
                builder: (ctx, userModel, child) {
                  return LoginButton('登录',
                    color: Colors.red,
                    textColor: Colors.white,
                    clickEvent: () async {
                      userModel.userInfo = await handleLogin();
                      Navigator.of(context).pushNamed(MainPage.routerName);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // input
  Widget _buildInput({
    String hintText,
    isShowIcon = false,
    bool obscureText = false,
    TextEditingController controller
  }) {
    return Container(
      height: 40.px,
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: Colors.grey))
      ),
      child: TextField(
      controller: controller,
      obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          icon: isShowIcon ? Container(
            width: 45.px,
            child: Row(
              children: <Widget>[
                Text('+86'),
                Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ) : null,
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
        ),
      ),
    );
  }
}