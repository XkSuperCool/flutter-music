import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/model/songListModel/song_list_item_model.dart';
import 'package:flutter_music/extension/num_extension.dart';

class SongListInfo extends StatelessWidget {
  final SongLisItemModel detail;

  SongListInfo(this.detail);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Stack(
        children: <Widget>[
          _buildInfo()
        ],
      ),
    );
  }

  // 歌单信息
  _buildInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6.px),
          child: Image.network(
            detail.coverImgUrl,
            width: 140.px,
          ),
        ),
        SizedBox(width: 10.px),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                detail.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 17.px)
              ),
              _buildUserInfo(),
              Text(detail.description ?? '',
                style: TextStyle(color: Color.fromRGBO(207, 210, 217, 1)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ],
    );
  }

  // 创建歌单的用户信息
  Widget _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.px),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(detail.creator.avatarUrl),
          ),
          SizedBox(width: 5.px),
          Text(detail.creator.nickname, style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}