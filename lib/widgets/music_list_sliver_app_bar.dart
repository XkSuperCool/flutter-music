import 'dart:ui' show  ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flexible_detail_bar.dart';
import 'music_cover_progress.dart';

class MusicListSliverAppBar extends StatelessWidget {
  final String title;
  final Widget content;
  final String coverImgUrl;
  final double expandedHeight;
  final Widget leading;
  final PreferredSizeWidget bottom;
  final Widget background;

  MusicListSliverAppBar({
    this.title,
    this.bottom,
    this.leading,
    this.background,
    this.coverImgUrl,
    @required this.expandedHeight,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        title: Text(title ?? '歌单'),
        centerTitle: true,
        expandedHeight: expandedHeight,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: leading ?? IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: FlexibleDetailBar(
          content: content,
          background: background ?? Stack(
            children: <Widget>[
              Transform.scale(
                scale: 1.5,
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: MediaQuery.of(context).size.height / 2.5
                  ),
                  child: Image.network(
                    coverImgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  color: Colors.black38,
                  width: double.infinity,
                  height: double.infinity,
                )
              )
            ],
          )
        ),
        bottom: bottom,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 11),
            child: MusicCoverProgress(),
          )
        ],
    );
  }
}