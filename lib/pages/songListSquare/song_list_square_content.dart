import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'song_list_tab_view.dart';

class SquareContent extends StatefulWidget {
  @override
  SquareContentState createState() => SquareContentState();
}

class SquareContentState extends State<SquareContent> with SingleTickerProviderStateMixin {
  TabController _controller;
  List<String> _tabBarTitles = ['说唱', '华语', '流行', '轻音乐', '摇滚', '民谣', '电子', '影视原声', 'ACG'];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 9, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          isScrollable: true,
          controller: _controller,
          tabs: _buildTabBarTitle(),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10.px),
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            child: TabBarView(
              controller: _controller,
              children: _buildTabView(),
            ),
          ),
        )
      ],
    );
  }

  // TabBar 的标题 List
  List<Widget> _buildTabBarTitle() {
    return _tabBarTitles.map((title) {
      return Padding(
        padding: EdgeInsets.all(10.px),
        child: Text(title),
      );
    }).toList();
  }

  // TabView
  List<Widget> _buildTabView() {
    return _tabBarTitles.map((item) {
      return SongListTabView(item);
    }).toList();
  }
}