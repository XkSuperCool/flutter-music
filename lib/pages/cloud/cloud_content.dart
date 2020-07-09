import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/widgets/music_header.dart';

import 'cloud_square.dart';

class CloudContent extends StatefulWidget {
  @override
  CloudContentState createState() => CloudContentState();
}

class CloudContentState extends State<CloudContent> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
      fontSize: 16.px,
      fontWeight: FontWeight.bold
    );

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 70.px),
          child: Padding(
            padding: EdgeInsets.only(left: 10.px, right: 10.px, top: 6.px),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                CloudSquare(),
                Text('2'),
              ],
            ),
          ),
        ),
        MusicHeader(
          leftWidget: IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {},
          ),
          title: FractionallySizedBox(
            widthFactor: .6,
            child: TabBar(
              controller: _tabController,
              labelPadding: EdgeInsets.only(bottom: 5.px),
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: _labelStyle,
              unselectedLabelStyle: _labelStyle,
              tabs: <Widget>[
                Text('广场'),
                Text('关注'),
              ],
            ),
          ),
        )
      ],
    );
  }
}