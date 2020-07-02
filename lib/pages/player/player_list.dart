import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:provider/provider.dart';

class PlayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment(0, .9),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width - 30.px,
          padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 10.px),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.px)
          ),
          child: Selector<MusicViewModel, List<MusicItemModel>>(
            builder: (ctx, musicList, childWidget) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildTitle(musicList.length),
                  Expanded(
                    child: _buildMusicList(context, musicList),
                  ),
                  childWidget
                ],
              );
            },
            selector: (ctx, musicModel) => musicModel.musicList,
            child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text('关闭', style: TextStyle(
                fontSize: 20,
              )),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        )
      ),
    );
  }

  // 标题
  _buildTitle(int counter) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Text('当前播放',style: TextStyle(
            fontSize: 20.px,
          )),
          Text('($counter)', style: TextStyle(
            color: Colors.grey,
            fontSize: 16.px,
          ))
        ],
      )
    );
  }

  // 音乐列表
  _buildMusicList(BuildContext context, List<MusicItemModel> musics) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: musics.length,
        itemBuilder: (ctx, index) {
          // 歌名
          String name = musics[index].name;
          // 歌手
          String ars = musics[index].ar.map((i) => i.name).join(',');
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.px),
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(color: Color.fromRGBO(233, 233, 233, 1))
              )
            ),
            child: _buildMusicName(name, ars, index),
          );
        }
      ),
    );
  }

  // 歌曲名称
  Widget _buildMusicName(String name, String ars, int index) {
    return Consumer<MusicViewModel>(
       builder: (ctx, musicModel, child) {
         // 是不是当前播放的音乐
         Color color = musicModel.musicList[index].id == musicModel.currentPlayerMusicItem.id ? Colors.red : null;
         return GestureDetector(
           onTap: () => musicModel.getPlayMusic(musicModel.musicList[index]),
           child: Container(
             child: Row(
               children: <Widget>[
                 ConstrainedBox(
                   constraints: BoxConstraints(
                     maxWidth: 200
                   ),
                   child: Text(name,
                     style: TextStyle(
                      color: color,
                      fontSize: 15.px,
                    ),
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
                 Expanded(
                   child: Text(' - $ars',
                     style: TextStyle(
                       color: color,
                       fontSize: 12.px
                     ),
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
                 GestureDetector(
                   onTap: () => removeMusicItem(musicModel, index, ctx),
                   child: Icon(Icons.close, color: Colors.grey),
                 ),
               ],
             ),
           ),
         );
       },
    );
  }

  // 删除歌单中的一项
  removeMusicItem(MusicViewModel value, int index, BuildContext context) {
    int lastIndex = value.musicList.length - 1; // 歌单最后一项的 index
    // 是否为当前播放的歌曲
    bool isCurPlay = value.currentPlayerMusicItem.id == value.musicList[index].id;
    print(isCurPlay);

    if (lastIndex == 0) {
      // 处理播放列表为空
      value.audioPlayer.stop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else if (index == lastIndex && isCurPlay) {
      // 处理删除列表最后一项
      value.getPlayMusic(value.musicList[0]);
    } else if (isCurPlay) {
      // 处理删除当前播放歌曲
      value.getPlayMusic(value.musicList[index + 1]);
    }

    value.musicList.removeAt(index);
    // 自己给自己复制，触发 setter 刷新界面
    value.musicList = value.musicList;
  }
}