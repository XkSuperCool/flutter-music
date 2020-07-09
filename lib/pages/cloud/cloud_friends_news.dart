import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_music/pages/login/login.dart';
import 'package:flutter_music/services/cloud_api.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/widgets/click_animation.dart';
import 'package:flutter_music/viewModel/user_view_model.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/model/userModel/user_model.dart';
import 'package:flutter_music/services/music_provider_api.dart';
import 'package:flutter_music/model/cloudModel/friends_news_model.dart';
import 'package:flutter_music/model/cloudModel/user_attention_model.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';


class FriendsNews extends StatefulWidget {
  @override
  FriendsNewsState createState() => FriendsNewsState();
}

class FriendsNewsState extends State<FriendsNews> {
  FriendsNewsModel _friendsNews;
  List<UserAttentionModel> _userAttentions = [];
  Map<int, String> _type = {
    18: '分享单曲',
    19: '分享专辑',
    17: '分享电台节目',
    28: '分享电台节目',
    22: '转发',
    39: '发布视频',
    35: '分享歌单',
    13: '分享歌单',
    24: '专栏文章',
    41: '分享视频',
    21: '分享视频'
  };

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) async {
      final userInfoStr = await prefs.get('userInfo');
      if (userInfoStr == null) {
        return;
      }
      UserModel userInfo = UserModel.fromJson(json.decode(userInfoStr));

      Future.wait<dynamic>([
        CloudApi.getFriendsNews(),
        CloudApi.getUserAttentions(userInfo.profile.userId)
      ]).then((res) {
        _friendsNews = res[0];
        _userAttentions = res[1];
        setState(() {});
      });
    });



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
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 90.px,
                    padding: EdgeInsets.symmetric(vertical: 6.px),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: BorderDirectional(
                            bottom: BorderSide(color: Color.fromRGBO(245, 245, 245, 1))
                        )
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _userAttentions.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            width: 70.px,
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 25.px,
                                  backgroundImage: NetworkImage(_userAttentions[index].avatarUrl),
                                ),
                                Text(_userAttentions[index].nickname,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  )
                ]
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 20.px, left: 10.px, right: 10.px, top: 10.px),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: BorderDirectional(
                            bottom: BorderSide(color: Color.fromRGBO(245, 245, 245, 1))
                        )
                    ),
                    child: _buildNewsItem(index),
                  );
                },
                childCount: _friendsNews != null ? _friendsNews.event.length : 0
            ),
          )
        ],
      ),
    );
  }

  _buildNewsItem(int index) {
    List<Event> event = _friendsNews?.event;
    Map<String, dynamic> info = json.decode(event[index].json);
    // 时间戳转换
    DateTime date = DateTime.fromMillisecondsSinceEpoch(1592402039446);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(event[index].user.avatarUrl),
        ),
        SizedBox(width: 10.px),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(event[index].user.nickname),
                  SizedBox(width: 10.px),
                  Text(_type[event[index].type], style: TextStyle(
                    fontSize: 14.px,
                  )),
                ],
              ),
              Text('${ date.month }月${ date.day }日', style: TextStyle(
                color: Colors.grey,
                fontSize: 12.px
              )),
              info['msg'].length != 0 ? Container(
                margin: EdgeInsets.symmetric(vertical: 6.px),
                child: Text(info['msg'], style: TextStyle(fontSize: 14.px)),
              ) : SizedBox(height: 5.px),
              _buildContent(event[index]),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 10.px),
                margin: EdgeInsets.symmetric(vertical: 10.px),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(237, 242, 246, 1),
                  borderRadius: BorderRadius.circular(4.px)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.language, color: Color.fromRGBO(77, 123, 172, 1), size: 12.px),
                    SizedBox(width: 5.px),
                    Text('${ event[index].tailMark.markTitle }', style: TextStyle(
                      fontSize: 12.px,
                      color: Color.fromRGBO(77, 123, 172, 1)
                    ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildButton(Icons.share, text: event[index].info.shareCount.toString()),
                  _buildButton(Icons.message, text: event[index].info.commentCount.toString()),
                  _buildButton(IconData(0xe66a, fontFamily: 'iconfont'), text: event[index].info.likedCount.toString()),
                  _buildButton(Icons.more_vert),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  _buildButton(IconData icon, { String text }) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 14.px),
        SizedBox(width: 5.px),
        Text(text ?? '')
      ],
    );
  }

  _buildContent(Event event) {
    int type = event.type;
    if (type == 18) {
      return _buildSingleMusic(event);
    } else if (type == 39) {
      return _buildVideo(event);
    }

    return SizedBox();
  }

  _buildSingleMusic(Event event) {
    Map<String, dynamic> info = json.decode(event.json);

    return Selector<MusicViewModel, MusicViewModel>(
      builder: (ctx, musicModel, child) {
        return ClickAnimation(
          onTap: () async {
            MusicItemModel music = await MusicProviderApi.getMusicDetail(info['song']['id']);
            musicModel.getPlayMusic(music);
          },
          child: child,
        );
      },
      selector: (ctx, musicModel) => musicModel,
      shouldRebuild: (prev, next) => false,
      child: Container(
        padding: EdgeInsets.all(6.px),
        decoration: BoxDecoration(
            color: Color.fromRGBO(245, 245, 245, 1),
            borderRadius: BorderRadius.circular(6.px)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6.px),
              child: info['song']['img80x80'] != null ? Image.network(info['song']['img80x80'], width: 40.px) : SizedBox(),
            ),
            SizedBox(width: 10.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info['song']['name'], style: TextStyle(
                    fontSize: 15.px,
                  )),
                  Text(info['song']['artists'].map((item) => item['name']).join(','),
                    style: TextStyle(
                        color: Color.fromRGBO(131, 131, 133, 1)
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildVideo(Event event) {
    Map<String, dynamic> info = json.decode(event.json);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 150.px,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.px),
            child: Image.network(info['video']['coverUrl'], fit: BoxFit.cover),
          )
        ),
        Positioned(
          child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40.px),
        )
      ],
    );
  }
}