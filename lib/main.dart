import 'package:flutter_music/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils/size_fit.dart';
import 'viewModel/music_view_model.dart';
import 'package:flutter_music/theme/theme.dart';
import 'package:flutter_music/pages/main/main.dart';
import 'package:flutter_music/router/router.dart';

main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MusicViewModel()),
      ChangeNotifierProvider(create: (context) => UserViewModel()),
    ],
    child: MusicApp(),
  )
);

class MusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 屏幕适配方案初始化
    SizeFit.initialize();

    return MaterialApp(
      theme: theme,
      home: MainPage(),
      routes: Router.routers,
    );
  }
}