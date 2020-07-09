import 'dart:async';
import 'dart:ui' show ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_music/services/cloud_api.dart';
import 'package:flutter_music/services/comment_api.dart';
import 'package:flutter_music/widgets/music_header.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/services/music_provider_api.dart';
import 'package:flutter_music/model/commentModel/comment_model.dart';
import 'package:flutter_music/model/cloudModel/hot_comment_model.dart';
import 'package:flutter_music/model/musicProviderModel/current_music.dart';


class HotCommentWallContent extends StatefulWidget {
  @override
  HotCommentContentWallState createState() => HotCommentContentWallState();
}

class HotCommentContentWallState extends State<HotCommentWallContent> {
  Timer _timer;
  int _currentIndex = 0;
  bool _isShowOtherComment = true;
  CurrentMusicModel _music;
  CommentModel _musicComments;
  FocusNode _focusNode = FocusNode();
  AudioPlayer _audioPlayer = AudioPlayer();
  List<HotCommentModel> _hotComments = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    CloudApi.getHotComment().then((res) async {
      _hotComments = res;
      // 获取第一首歌曲额评论数据
      await _getMusicComment(res[0].simpleResourceInfo.songId);
      setState(() {});
      // 歌曲播放
      _musicPlay(_hotComments[0].simpleResourceInfo.songId);
    });

    _timerScroll();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _clearTimer();
        // TODO: 隐藏滚动评论时清除定时滚动
        _isShowOtherComment = false;
      } else {
        // TODO：显示滚动评论时开启定时滚动
        _isShowOtherComment = true;
        _timerScroll();
      }
      setState(() {});
    });
  }

  // 定时器函数：5s 执行一次，滚动歌曲热评
  _timerScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (t) {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _scrollController.jumpTo(0);
      }

      _scrollController.animateTo(
        _scrollController.position.pixels + 40.px,
        duration: Duration(seconds: 1),
        curve: Curves.linear
      );
    });
  }

  // 音樂播放
  _musicPlay(int id) async {
    _music = await MusicProviderApi.getPlayMusic(id);
    _audioPlayer.play(_music.url);
  }

  // 获取歌曲评论
  _getMusicComment(int id) async {
    _musicComments = await CommentApi.getHotComment(id);
  }

  // 清除定时器
  _clearTimer() {
    if (_timer != null) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
  }

  @override
  void dispose() {
    _clearTimer();
    _scrollController.dispose();
    _audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hotComments.length == 0) return SizedBox();

    return Stack(
      children: <Widget>[
        _buildCover(),
        _buildContainer(),
        Positioned(
          bottom: 90.px,
          left: 0,
          right: 0,
          child: _otherComment()
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildReply()
        ),
      ],
    );
  }

  // 底部封面图
  Widget _buildCover() {
    return Transform.scale(
      scale: 2,
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Image.network(
          _hotComments[_currentIndex].simpleResourceInfo.songCoverUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 回复框
  Widget _buildReply() {
    return SafeArea(
      child: Container(
        height: 60.px,
        padding: EdgeInsets.all(10.px),
        color: Color.fromRGBO(20, 20, 20, 1),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '请输入内容',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.px),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                )
              ),
            ),
            _buildButton(Icons.favorite, '${ _hotComments[_currentIndex].likedCount }'),
            SizedBox(width: 10.px),
            _buildButton(Icons.textsms, '${ _hotComments[_currentIndex].replyCount }'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Colors.grey, size: 14.px),
        Text(' $text', style: TextStyle(color: Colors.grey))
      ],
    );
  }

  // 主体内容布局
  Widget _buildContainer() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black38,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MusicHeader(
              color: Colors.transparent,
              rightWidget: Padding(
                padding: EdgeInsets.only(right: 10.px),
                child: Text('${ _currentIndex + 1 }/${ _hotComments.length }', style: TextStyle(color: Colors.grey)),
              ),
              title: Text('热评墙', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white,
                fontSize: 16.px,
                fontWeight: FontWeight.bold
              )),
              leftWidget: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: PageView(
                  children: _hotComments.map((item) => _buildComment(item)).toList(),
                  onPageChanged: (index) async {
                    _currentIndex = index;
                    _scrollController.jumpTo(0);
                    int id = _hotComments[index].simpleResourceInfo.songId;
                    await _getMusicComment(id);
                    await _musicPlay(id);
                    setState(() {});
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  // 热评内容
  Widget _buildComment(HotCommentModel commentItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RawChip(
          padding: EdgeInsets.zero,
          backgroundColor: Color.fromRGBO(135, 135, 137, 1),
          avatar: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(commentItem.simpleUserInfo.avatar),
          ),
          label: Text('+ 关注', style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 15.px),
        Icon(IconData(0xe61a, fontFamily: 'iconfont'), color: Colors.grey, size: 30.px),
        Container(
          margin: EdgeInsets.only(bottom: 10.px),
          child: Text(commentItem.content, style: TextStyle(
            color: Colors.white,
            fontSize: 19.px
          )),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 15.px,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5,
                minHeight: 15.px
              ),
              child: Selector<MusicViewModel, MusicViewModel>(
                builder: (ctx, musicModel, child) {
                  musicModel.audioPlayer.pause(); // 暂停播放音乐
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      Text('${ commentItem.simpleResourceInfo.name } - ${ commentItem.simpleResourceInfo.song.ar.map((item) => item.name).join(',') }',
                        style: TextStyle(color: Colors.grey, ),
                      )
                    ],
                  );
                },
                selector: (ctx, musicModel) => musicModel,
                shouldRebuild: (prev, next) => false,
              ),
            ),
            SizedBox(width: 10.px),
            Icon(Icons.favorite_border, color: Colors.grey, size: 15.px),
          ],
        )
      ],
    );
  }

  // 歌曲下面的其他热评
  Widget _otherComment() {
    return _isShowOtherComment ? Container(
      height: 80.px,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              controller: _scrollController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _musicComments != null ? _musicComments.hotComments.length :  0,
              itemBuilder: (ctx, index) => (
                Container(
                  height: 40.px,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  child: RawChip(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Color.fromRGBO(64, 64, 64, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.px),
                            topRight: Radius.circular(20.px),
                          )
                        ),
                        builder: (context) {
                          return Container(
                            width: double.infinity,
                            height: 150.px,
                            padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 20.px),
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(_musicComments.hotComments[index].user.avatarUrl),
                                    ),
                                    SizedBox(width: 10.px),
                                    Text(_musicComments.hotComments[index].user.nickname, style: TextStyle(
                                      color: Colors.grey
                                    ))
                                  ],
                                ),
                                SizedBox(height: 10.px),
                                Text(_musicComments?.hotComments[index].content, style: TextStyle(
                                  color: Colors.white
                                ))
                              ],
                            ),
                          );
                        }
                      );
                    },
                    backgroundColor: Color.fromRGBO(135, 135, 137, 1),
                    avatar: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_musicComments?.hotComments[index].user.avatarUrl ),
                    ),
                    label: _buildCommentItemText(_musicComments?.hotComments[index].content),
                  ),
                )
              )
            ),
          ),
          Positioned(
            bottom: -36.px,
            left: 0,
            right: 0,
            child: Container(
              height: 80.px,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black38, Colors.black54]
                )
              ),
            ),
          )
        ],
      ),
    ) : SizedBox();
  }

  _buildCommentItemText(String content) {
    return Text(
      content,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}