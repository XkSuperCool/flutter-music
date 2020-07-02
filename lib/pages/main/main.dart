import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'initialization.dart';
import 'package:flutter_music/pages/discovery/discovery.dart';
import 'package:flutter_music/pages/video/video.dart';
import 'package:flutter_music/pages/my/my.dart';
import 'package:flutter_music/pages/cloud/cloud.dart';
import 'package:flutter_music/pages/account/account.dart';
import 'package:flutter_music/extension/num_extension.dart';

class MainPage extends StatefulWidget {
  static String routerName = '/main';

  @override
  MainState createState() => MainState();
}

class MainState extends State<MainPage> {
  int _initialPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.px,
        unselectedFontSize: 12.px,
        currentIndex: _initialPage,
        type: BottomNavigationBarType.fixed,
        items: buildBottomNavigationBarItems(_initialPage),
        onTap: (index) {
          _initialPage = index;
          _pageController.jumpToPage(index);
          setState(() {});
        },
      ),
      body: PageView(
        // 取消左右滑动切换页面
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          DiscoveryPage(),
          VideoPage(),
          MyPage(),
          CloudPage(),
          AccountPage()
        ]
      ),
    );
  }
}