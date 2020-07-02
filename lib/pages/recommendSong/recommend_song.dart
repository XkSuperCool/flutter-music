import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recomment_song_content.dart';

class RecommendSongPage extends StatelessWidget {
   static String routerName = '/recommendSong';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecommendSongContent(),
    );
  }
}