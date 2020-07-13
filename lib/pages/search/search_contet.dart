import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music/pages/player/player.dart';
import 'package:flutter_music/services/search_api.dart';
import 'package:flutter_music/widgets/music_header.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/services/music_provider_api.dart';
import 'package:flutter_music/model/searchModel/search_song_model.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';

class SearchContent extends StatefulWidget {
  final String searchKey;

  SearchContent(this.searchKey);

  @override
  SearchContentPage createState() => SearchContentPage();
}

class SearchContentPage extends State<SearchContent> {
  List<SearchSongModel> _searchMusics = [];

  @override
  void initState() {
    super.initState();
    _search();
  }

  _search() async {
    List<SearchSongModel> res = await SearchApi.getSongListByKey(widget.searchKey);
    _searchMusics.addAll(res);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 40.px),
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              return Consumer<MusicViewModel>(
                builder: (ctx, musicModel, child) {
                  Color color = _searchMusics[index].id == musicModel.currentPlayerMusicItem.id ? Colors.red : Colors.black;
                  return ListTile(
                    onTap: () async {
                      MusicItemModel music = await MusicProviderApi.getMusicDetail(_searchMusics[index].id);
                      bool isPlay = await musicModel.getPlayMusic(music);
                      if (isPlay) {
                        Navigator.of(context).pushNamed(PlayerPage.routerName);
                      }
                    },
                    title: Text(_searchMusics[index].name, style: TextStyle(color: color)),
                    subtitle: Row(
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Text(_searchMusics[index].artists.map((item) => item.name).join(','), style: TextStyle(color: color))
                                ),
                                WidgetSpan(
                                  child: Text(' - ${ _searchMusics[index].album.name }', style: TextStyle(color: color))
                                )
                              ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            separatorBuilder: (ctx, index) => Divider(height: 1.px),
            itemCount: _searchMusics.length
          ),
        ),
        MusicHeader()
      ],
    );
  }
}