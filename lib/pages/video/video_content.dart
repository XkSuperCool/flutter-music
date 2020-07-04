import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'video_tab_view.dart';
import 'package:flutter_music/pages/login/login.dart';
import 'package:flutter_music/servives/video_api.dart';
import 'package:flutter_music/widgets/music_header.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/viewModel/user_view_model.dart';
import 'package:flutter_music/model/videoModel/video_category_model.dart';

class VideoContent extends StatefulWidget {
  @override
  VideoContentState createState() => VideoContentState();
}

class VideoContentState extends State<VideoContent> with TickerProviderStateMixin {
  List<VideoCategory> _categoryList = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 获取视频列表
    _getVideoCategoryList();
    _tabController = TabController(length: _categoryList.length, vsync: this);
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 获取分类
  _getVideoCategoryList() async {
    _categoryList = await VideoApi.getVideoCategoryList();
    // 二次生成 controller
    _tabController = TabController(length: _categoryList.length, vsync: this);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: <Widget>[
          MusicHeader(
            leftWidget: IconButton(
              icon: Icon(IconData(0xe672, fontFamily: 'iconfont')),
              onPressed: () {},
            ),
          ),
          TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 15.px),
            controller: _tabController,
            tabs: _categoryList.map((item) => Text(item.name)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categoryList.map((item) => (
                ViewTabView(item.id)
              )).toList(),
            ),
          )
        ],
      ),
    );
  }
}