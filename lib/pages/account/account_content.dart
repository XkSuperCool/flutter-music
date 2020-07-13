import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_music/pages/login/login.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/viewModel/user_view_model.dart';
import 'package:flutter_music/pages/my/my_app_bar_bottom.dart';
import 'package:flutter_music/widgets/music_cover_progress.dart';

class AccountContent extends StatelessWidget {
  final List<String> _musicServices = ['演出', '商城', '口袋彩铃', '在线免流量听歌'];
  final List<String> _tools = ['设置', '夜间模式', '定时关闭', '音乐黑名单', '鲸云音效', '关于'];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.black,
          leading: IconButton(icon: Icon(Icons.fullscreen), onPressed: () {}),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.px),
              child: MusicCoverProgress(),
            )
          ],
          expandedHeight: 190.px,
          flexibleSpace: _buildFlexibleSpace(),
          bottom: AppBarBottom(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _buildContainer(context)
            ]
          ),
        )
      ],
    );
  }

  Widget _buildFlexibleSpace() {
    Color vipColor = Color.fromRGBO(246, 218, 214, 1);
    return FlexibleSpaceBar(
      background: Container(
        color: Colors.black,
        padding: EdgeInsets.only(top: 50.px, left: 20.px, right: 20.px),
        child: Container(
          padding: EdgeInsets.only(top: 20.px),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.px),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(50, 50, 50, 1),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(15.px),
                    topEnd: Radius.circular(15.px),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      child: Text('黑胶 VIP', style: TextStyle(
                        color: vipColor,
                        fontSize: 20.px,
                        fontWeight: FontWeight.bold
                      ))
                    ),
                    _buildGradientContainer(
                      colors: [Color.fromRGBO(245, 217, 213, 1), Color.fromRGBO(213, 183, 175, 1)],
                      child: Text('会员中心'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromRGBO(49, 49, 49, 1),
                  padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 5.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('会员专属头像挂件上新', style: TextStyle(
                            color: vipColor
                          )),
                          Text('一梦江湖，幸好有你', style: TextStyle(
                            color: Color.fromRGBO(145, 131, 127, 1)
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage('http://imgup04.golue.com/golue/2019-07/28/12/15642893127903_0.jpg'),
                          ),
                          Icon(Icons.chevron_right, color: Colors.white)
                        ],
                      )
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Consumer<UserViewModel>(
            builder: (ctx, userModel, child) {
              String url = userModel.userInfo != null ? userModel.userInfo.profile.avatarUrl : 'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2394476310,242886317&fm=26&gp=0.jpg';
              String nickName = userModel.userInfo != null ? userModel.userInfo.profile.nickname : '去登录';
              return Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20.px, right: 20.px, top: 5.px, bottom: 20.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (nickName == '去登录') Navigator.of(context).pushNamed(LoginPage.routerName);
                      },
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(url),
                          ),
                          SizedBox(width: 10.px),
                          Text(nickName, style: TextStyle(
                            fontSize: 16.px
                          ))
                        ],
                      ),
                    ),
                    _buildGradientContainer(
                      colors: [Color.fromRGBO(255, 86, 71, 1), Color.fromRGBO(255, 36, 27, 1)],
                      child: Text('签到', style: TextStyle(color: Colors.white))
                    )
                  ],
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.px),
            child: _buildListItem('创作者中心')
          ),
          _buildList(context, _musicServices),
          SizedBox(height: 10.px),
          _buildList(context, _tools),
          Consumer<UserViewModel>(
            builder: (ctx, userModel, child) {
              return Container(
                width: double.infinity,
                height: 40.px,
                margin: EdgeInsets.only(top: 10.px),
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.white,
                  child: Text('退出登录', style: TextStyle(fontSize: 14.px, color: Colors.red)),
                  onPressed: () async {
                    // 清除操作
                    userModel.userInfo = null;
                    userModel.isLogin = false;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('userInfo');
                    prefs.remove('cookie');
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildGradientContainer({ @required List<Color> colors, @required Widget child }) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 3.px),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors
        ),
        borderRadius: BorderRadius.circular(100.px)
      ),
      child: child
    );
  }

  Widget _buildListItem(String text) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Text(text, style: TextStyle(fontSize: 14.px)),
        trailing:  IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {},
        )
      ),
    );
  }

  Widget _buildList(BuildContext context, List<String> list) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => _buildListItem(list[index]),
        separatorBuilder: (ctx, index) => Divider(height: 1.px),
        itemCount: list.length
      ),
    );
  }
}