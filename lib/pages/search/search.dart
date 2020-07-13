import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/widgets/music_header.dart';

import 'search_contet.dart';

class SearchPage extends StatelessWidget {
   static String routerName = '/search';

  @override
  Widget build(BuildContext context) {
    String _searchKey = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SearchContent(_searchKey),
    );
  }
}