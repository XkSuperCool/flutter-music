import 'dart:convert' as convert;
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'music_card.dart';
import 'my_music_box.dart';
import 'my_app_bar_bottom.dart';
import 'package:flutter_music/servives/user_api.dart';
import 'package:flutter_music/pages/login/login.dart';
import 'package:flutter_music/pages/songList/song_list.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/userModel/user_model.dart';
import 'package:flutter_music/widgets/music_list_sliver_app_bar.dart';
import 'package:flutter_music/model/userModel/user_song_list_model.dart';

class MyContent extends StatefulWidget {
  @override
  MyContentState createState() => MyContentState();
}

class MyContentState extends State<MyContent> with TickerProviderStateMixin {
  UserModel _userInfo;
  UserSongListModel _userLike; // 用户喜欢的音乐
  List<UserSongListModel> _userCreate = []; // 用户创建的
  List<UserSongListModel> _userCollect = []; // 用户收藏的
  List<UserSongListModel> _currentSongList = []; // 当前展示的歌单
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initData();
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 初始化数据
  _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.get('userInfo');
    if (userInfo == null) {
      return;
    }
    _userInfo = UserModel.fromJson(convert.jsonDecode(userInfo));
    // 获取用户歌单
    List<UserSongListModel> res = await UserApi.getUserSongList(_userInfo.profile.userId);
    _userLike = res[0];
    res.removeAt(0); // 移出用户喜欢的歌单
    _userCreate = res.where((item) => item.userId == _userInfo.profile.userId).toList();
    _userCollect = res.where((item) => item.userId != _userInfo.profile.userId).toList();
    _currentSongList = _userCreate;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_userInfo == null) {
      return Consumer<UserViewModel>(
        builder: (ctx, userModel, child) {
          if (!userModel.isLogin) {
            // TODO: 延迟跳转，否则报错 setState() or markNeedsBuild() called during build.
            Future.delayed(Duration(milliseconds: 0)).then((e) {
              Navigator.of(context).pushNamed(LoginPage.routerName);
            });
          }
          return child;
        },
        child: Center(
          child: CupertinoActivityIndicator(radius: 12.px)
        ),
      );
    }

    return CustomScrollView(
      slivers: <Widget>[
        _buildHeader(context),
        SliverList(
          delegate: SliverChildListDelegate([
            _buildContent()
          ])
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) => Container(
              padding: EdgeInsets.only(left: 15.px, bottom: 5.px, right: 15.px),
              child: MusicBox(
                title: _currentSongList[index].name,
                desc: '${ _currentSongList[index].trackCount }首',
                backgroundImgUrl: _currentSongList[index].coverImgUrl,
                onTap: () =>  Navigator.of(context).pushNamed(SongListPage.routerName, arguments: _currentSongList[index].id),
              ),
            ),
            childCount: _currentSongList.length
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.7,
          )
        )
      ],
    );
  }

  // Header
  Widget _buildHeader(BuildContext context) {
    return MusicListSliverAppBar(
      title: '',
      expandedHeight: 170.px,
      background: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              'https://img.599ku.com/element_pic/69/12/81/67/08610b3bfcfd0680ddcc206b191cd338.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black26,
          ),
        ],
      ), // 传递空，隐藏 background
      leading: IconButton(
        color: Colors.white,
        icon: Icon(IconData(0xe834, fontFamily: 'iconfont')),
        onPressed: () {},
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60),
            _buildTopWidget(context)
          ]
        ),
      ),
      bottom: AppBarBottom(),
    );
  }

  // 主体
  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle('我的音乐', top: 0),
          Container(
            height: 150.px,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                MusicCard(
                  backgroundImgUrl: _userLike.coverImgUrl,
                  onTab: () => Navigator.of(context).pushNamed(SongListPage.routerName, arguments: _userLike.id),
                  centerWidget: _buildCardCenterWidget('我喜欢的音乐', Icons.favorite),
                  bottomWidget: RawChip(
                    backgroundColor: Color.fromRGBO(135, 135, 137, 1),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.play_arrow, color: Colors.white, size: 15.px),
                    ),
                    label: Text('心动模式', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10.px),
                MusicCard(
                  backgroundImgUrl: 'http://p1.music.126.net/UU09arK_fRlyWVdh2znikA==/109951163610766464.jpg?param=177y177',
                  centerWidget: _buildCardCenterWidget('私人 FM', Icons.movie_filter, color: Colors.white),
                  bottomWidget: Text('你的私人曲库', style: TextStyle(color: Colors.white70)),
                ),
                SizedBox(width: 10.px),
                MusicCard(
                  color: Color.fromRGBO(245, 241, 238, 1),
                  centerWidget: _buildCardCenterWidget('因乐交友', Icons.audiotrack, color: Color.fromRGBO(154, 108, 84, 1)),
                  bottomWidget: Text('找到音乐好友', style: TextStyle(color: Color.fromRGBO(222, 202, 201, 1))),
                ),
              ],
            ),
          ),
          _buildTitle('最近播放'),
          _buildContainer(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                MusicBox(title: '全部已播放音乐', desc: '300首', backgroundImgUrl: 'http://p4.music.126.net/13AS_jmQb5ImlNQ86jT0DQ==/109951165069371512.jpg?param=200y200'),
                MusicBox(
                  onTap: () => Navigator.of(context).pushNamed(SongListPage.routerName, arguments: 621983415),
                  title: '专辑：2017·以下范上',
                  desc: '继续播放',
                  backgroundImgUrl: 'http://p2.music.126.net/JmeLbT0Z3dkRGoP-G3Xh1w==/18604836255326600.jpg?param=177y177'
                ),
              ],
        )
          ),
          Container(
            width: 130.px,
            child: TabBar(
              labelPadding: EdgeInsetsDirectional.only(),
              indicator: BoxDecoration(
              ),
              controller: _tabController,
              tabs: <Widget>[
                Container(
                  width: 70.px,
                  child: Tab(child: _buildTitle('创建歌单 ')),
                ),
                Container(
                  width: 70.px,
                  child: Tab(child: _buildTitle(' 收藏歌单')),
                ),
              ],
              onTap: (index) {
                _currentSongList = index == 0 ? _userCreate : _userCollect;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  // 顶部 Widget
  Widget _buildTopWidget(BuildContext context) {
    if (_userInfo == null) return SizedBox();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 20.px),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(_userInfo.profile.avatarUrl),
              ),
              SizedBox(width: 10.px),
              Text(_userInfo.profile.nickname, style: TextStyle(
                color: Colors.white,
                fontSize: 16.px
              ))
            ],
          ),
        ],
      ),
    );
  }

  // 标题
  Widget _buildTitle(String title, { double top = 10, double bottom = 10 }) {
    return Container(
      margin: EdgeInsets.only(
        top: top.px,
        bottom: bottom.px
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 15.px, fontWeight: FontWeight.w600)
      ),
    );
  }

  Widget _buildContainer({ Widget child }) {
    return Container(
      height: 60.px,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  // 卡片中间 widget
  _buildCardCenterWidget(String text, IconData icon, { Color color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color ?? Colors.red, size: 35.px),
        Text(text, style: TextStyle(color: color ?? Colors.white))
      ],
    );
  }
}