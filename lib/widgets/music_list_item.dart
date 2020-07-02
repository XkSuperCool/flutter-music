import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

class MusicListItem extends StatelessWidget {
  final int _index;
  final MusicItemModel _track;
  final currentPlayMusicId;

  MusicListItem(this._index, this._track, this.currentPlayMusicId);

  @override
  Widget build(BuildContext context) {
    Color color;
    if (currentPlayMusicId == _track.id) {
      color = Colors.red;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 15.px),
      child: Row(
        children: <Widget>[
          Text('${ _index + 1 }', style: TextStyle(
            fontSize: 20.px, color: color ?? Colors.grey
          )),
          SizedBox(width: 10.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_track.name,
                  style: TextStyle(color: color, fontSize: 15.px),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                _buildMusicInfo(color)
              ],
            ),
          )
        ],
      ),
    );
  }

  // 歌曲信息
  Widget _buildMusicInfo(Color color) {
    String name = _track.ar.map((i) => i.name).join(',');
    String album = _track.al.name;
    return Text('$name - $album',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color ?? Colors.grey)
    );
  }
}