import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';

import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/services/video_api.dart';

class VideoPlay extends StatefulWidget {
  final String id;
  final Key key;

  VideoPlay(this.id, { this.key }) : super(key: key);

 @override
 VideoPlayState createState() => VideoPlayState();
}

class VideoPlayState extends State<VideoPlay> {
  final FijkPlayer _player = FijkPlayer();

  @override
  void initState() {
    super.initState();

    // 获取 url
    VideoApi.getVideoUrl(widget.id).then((url) {
      _player.setDataSource(url, autoPlay: true);
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _player.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.px,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.px),
        child: FijkView(
          player: _player,
          fit: FijkFit.cover,
        ),
      ),
    );
  }
}