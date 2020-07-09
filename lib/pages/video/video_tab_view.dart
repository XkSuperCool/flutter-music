import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'video_play.dart';
import 'package:flutter_music/services/video_api.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/videoModel/video_list_item.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/utils/util.dart' show formatCounter, formatDate;

class ViewTabView extends StatefulWidget {
  final int id;

  ViewTabView(this.id);

  @override
  ViewTabViewState createState() => ViewTabViewState();
}

class ViewTabViewState extends State<ViewTabView> {
  RefreshController _refreshController;
  List<VideoListItem> _videoList = [];
  int _currentIndex;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _getVideoList();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  // 获取视频列表
  _getVideoList({ int offset = 0 }) async {
    List<VideoListItem> res = await VideoApi.getVideoList(widget.id, offset: offset);
    _videoList.addAll(res);
    if (mounted) setState(() {});
  }

  // 下拉刷新
  void _onRefresh() async {
    _videoList = [];
    _offset = 0;
    await _getVideoList();
    _refreshController.refreshCompleted();
  }

  // 上拉加载更多
  void _onLoading() async {
    await _getVideoList(offset: ++_offset);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoList.length == 0) return Center(child: CupertinoActivityIndicator(radius: 10.px));

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        header: WaterDropMaterialHeader(),
        footer: CustomFooter(
          builder: _buildCustomFooter
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: _videoList.length,
          itemBuilder: (ctx, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            child: (
              Column(
                children: <Widget>[
                  SizedBox(height: 10.px),
                  _buildVideoCover(_videoList[index], index),
                  _buildVideoInfo(_videoList[index])
                ],
              )
            ),
          )
        ),
      ),
    );
  }

  // 上拉加载提示
  Widget _buildCustomFooter(BuildContext context, LoadStatus mode){
    Widget body;
    if(mode == LoadStatus.idle){
      body =  Text("上拉加载");
    }
    else if(mode == LoadStatus.loading){
      body =  CupertinoActivityIndicator();
    }
    else if(mode == LoadStatus.failed){
      body = Text("加载失败！点击重试！");
    }
    else if(mode == LoadStatus.canLoading){
      body = Text("松手,加载更多!");
    }
    else{
      body = Text("没有更多数据了!");
    }
    return Container(
      height: 55.0,
      child: Center(child:body),
    );
  }

  // 视频封面
  _buildVideoCover(VideoListItem video, int index) {
    return Selector<MusicViewModel, AudioPlayer>(
      builder: (ctx, autoPlay, child) {
        return GestureDetector(
          onTap: () {
            _currentIndex = index;
            autoPlay.pause(); // 暂停播放音乐
            setState(() {});
          },
          child: child,
        );
      },
      selector: (ctx, musicModel) => musicModel.audioPlayer,
      child: _currentIndex != index ? Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.px),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 180.px,
              child: Image.network(video.coverUrl, fit: BoxFit.cover)
            )
          ),
          Positioned(
            bottom: 5.px,
            left: 10.px,
            child: Row(
              children: <Widget>[
                Icon(Icons.play_arrow, color: Colors.white, size: 13.px),
                SizedBox(width: 5.px),
                _buildText(
                  // 格式化播放数量
                  formatCounter(video.praisedCount),
                ),
              ],
            )
          ),
          Positioned(
            bottom: 5.px,
            right: 10.px,
            child: Row(
              children: <Widget>[
                Icon(Icons.timer, color: Colors.white, size: 14),
                _buildText(
                  // 格式化播放时间
                  formatDate((video.durationms / 60 / 1000).toStringAsFixed(2))
                )
              ],
            ),
          ),
          Positioned(
            top: 5.px,
            right: 10.px,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.px, horizontal: 10.px),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.px),
                border: Border.all(color: Colors.white60)
              ),
              child: _buildText(
                video.videoGroup[0].name,
                fontSize: 12.px
              ),
            ),
          ),
          Positioned(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white60,
              size: 50.px,
            ),
          )
        ],
      ) : VideoPlay(video.vid),
    );
  }

  // info
  _buildVideoInfo(VideoListItem video) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 60.px
      ),
      margin: EdgeInsets.only(top: 10.px, left: 3.px),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(video.title,
                  style: TextStyle(
                    fontSize: 16.px,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Selector<MusicViewModel, MusicViewModel>(
                builder: (ctx, musicModel, child) {
                  // 如果有推荐的相似音乐就展示
                  return video.relateSong.length > 0 ? GestureDetector(
                    onTap: () async {
                      bool isPlay = await musicModel.getPlayMusic(video.relateSong[0]);
                      if (isPlay) {
                        _currentIndex = null;
                        setState(() {});
                        Navigator.of(context).pushNamed(PlayerPage.routerName);
                      }
                    },
                    child: CircleAvatar(
                      radius: 15.px,
                      backgroundImage: NetworkImage(video.relateSong[0].al.picUrl),
                    ),
                  ) : SizedBox();
                },
                selector: (ctx, musicModel) => musicModel,
                shouldRebuild: (prev, next) => false,
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 15.px,
                      backgroundImage: NetworkImage(video.creator.avatarUrl),
                    ),
                    Text(' ' + video.creator.nickname)
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildStackBtn(
                      IconData(0xe66a, fontFamily: 'iconfont'),
                      video.commentCount
                    ),
                    _buildStackBtn(
                      IconData(0xe78f, fontFamily: 'iconfont'),
                      video.commentCount
                    ),
                    Icon(Icons.more_vert)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // 图标叠加数量
  _buildStackBtn(IconData icon, int counter) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Icon(icon, size: 14.px),
        Positioned(
          right: -15.px,
          top: -10.px,
          child: Text('$counter', style: TextStyle(fontSize: 10.px))
        )
      ],
    );
  }

  // Text
  Widget _buildText(String text, { double fontSize }) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize
      )
    );
  }
}