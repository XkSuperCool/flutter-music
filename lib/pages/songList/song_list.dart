import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/model/dscoveryModel/song_list_model.dart';

import 'song_list_content.dart';

class SongListPage extends StatelessWidget {
  static final String routerName = '/songlist';

  @override
  Widget build(BuildContext context) {
    int songListId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SongListContent(songListId)
    );
  }
}