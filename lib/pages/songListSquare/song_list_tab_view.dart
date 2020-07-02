import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/dscoveryModel/song_list_model.dart';
import 'package:flutter_music/pages/songList/song_list.dart';
import 'package:flutter_music/servives/song_list_api.dart';
import 'package:flutter_music/widgets/music_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SongListTabView extends StatefulWidget {
  final String tabBarTitle;

  SongListTabView(this.tabBarTitle);

  @override
  SongListTabViewState createState() => SongListTabViewState();
}

class SongListTabViewState extends State<SongListTabView> {
  List<SongListModel> _songList = [];

  RefreshController _refreshController;

  // 获取对应歌单
  Future<bool> _getSongListData(String tag, { int before }) async {
    List<SongListModel> res = await SongListApi.getSongListByTag(tag, before: before);
    _songList.addAll(res);

    // 没有数据时返回 false
    if (res.length == 0) return false;

    // TODO: 可能会出现 error: setState() called after dispose()
    // TODO: 解决： 判断 mounted 为 true 时再 setState，mounted 判断 StatefulWidget 是否存在
    // TODO: 出现的原因：网络请求慢，在未请求回来时切换 TabView 导致当前 SongListTabView 被 dispose，然后网络请求返回时当前 widget 已经被销毁了，所以会用 mounted 判断
    if (mounted) setState(() {});

    return true;
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _getSongListData(widget.tabBarTitle);
  }

  // 上拉加载
  void _onLoading() async{
    bool isEmpty = await _getSongListData(widget.tabBarTitle, before: _songList[_songList.length - 1].updateTime);
    // 根据是否加载到数据调用不同方法
    if (!isEmpty) _refreshController.loadNoData();
    else _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // loading
    if (_songList.length == 0) return Center(child: CupertinoActivityIndicator(radius: 15));

    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      onLoading: _onLoading,
      footer: _buildRefresherFooter(),
      controller: _refreshController,
      child: GridView.builder(
        itemCount: _songList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.px,
          crossAxisSpacing: 10.px,
          childAspectRatio: .75
        ),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () => Navigator.of(ctx).pushNamed(SongListPage.routerName, arguments:_songList[index].id),
            child: MusicCard(musicInfo: _songList[index]),
          );
        }
    ),
    );
  }

  Widget _buildRefresherFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode){
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("上拉加载");
        }
        else if (mode == LoadStatus.loading) {
          body =  CupertinoActivityIndicator();
        }
        else if (mode == LoadStatus.failed) {
          body = Text("加载失败！点击重试！");
        }
        else if (mode == LoadStatus.canLoading) {
          body = Text("松手,加载更多!");
        }
        else {
          body = Text("没有更多数据了!");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}