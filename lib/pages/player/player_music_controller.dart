import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music/utils/util.dart' show formatDate;
import 'package:flutter_music/viewModel/music_view_model.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'player_list.dart';

class MusicController extends  StatefulWidget {
  @override
  MusicControllerState createState() => MusicControllerState();
}

class MusicControllerState extends State<MusicController> {
  double _trackHeight = 2.0; // 进度条高度


  // 播放时间生成
  List<String> _generateDate(int durationMillisecond, double progress) {
    // 获取音乐当前已播放时长 - 毫秒
    double curDuration = durationMillisecond * progress;
    // 音乐总时长、当前已播放时长 - 分钟
    String durationMinute = (durationMillisecond / 1000 / 60).toStringAsFixed(2);
    String curDurationMinute = (curDuration / 1000 / 60).toStringAsFixed(2);
    // 时间格式化， -> 00:00 格式
    durationMinute = formatDate(durationMinute);
    curDurationMinute = formatDate(curDurationMinute);

    return [curDurationMinute, durationMinute];
  }

  // 获取播放模式对应的 icon path
  String _getModePath(MusicPlayerMode mode) {
    if (mode == MusicPlayerMode.SingleCycle) {
      return 'single_player';
    } else if (mode == MusicPlayerMode.ListCycle){
      return 'cycle_player';
    } else {
      return 'random_player';
    }
  }

  // 设置音乐播放模式
  MusicPlayerMode _setMusicPlayerMode(MusicPlayerMode mode) {
    if (mode == MusicPlayerMode.ListCycle) {
      return MusicPlayerMode.RandomPlayer;
    } else if (mode == MusicPlayerMode.RandomPlayer) {
      return MusicPlayerMode.SingleCycle;
    } else {
      return MusicPlayerMode.ListCycle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.px),
        child: Column(
          children: <Widget>[
            _buildProgress(),
            _buildControl()
          ],
        ),
      ),
    );
  }

  // 进度条
  Widget _buildProgress() {
    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child) {
        // 获取音乐播放总时长，毫秒
        int duration = musicModel.musicDuration ?? 0;
        List<String> musicDate = _generateDate(duration, musicModel.progress);
        return Row(
          children: <Widget>[
            Text(musicDate[0], style: TextStyle(color: Colors.white, fontSize: 12)),
            SizedBox(width: 10.px),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(ctx).copyWith(
                  trackHeight: _trackHeight, // 进度条高度
                  thumbColor: Colors.white, // 滑块颜色
                  activeTrackColor: Color.fromRGBO(143, 145, 157, 1), // 进度条颜色
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 3 + _trackHeight, // 滑块大小
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 0, // 滑块外圈大小
                  )
                ),
                child: Slider(
                  value: musicModel.progress,
                  // 拖动改变音乐进度
                  onChanged: (value) {
                    musicModel.flag = true; // 上锁
                    musicModel.progress = value;
                    _trackHeight = 4; // 拖动时把进度条放大
                  },
                  onChangeEnd: (value) async {
                    musicModel.flag = false; // 解锁
                    // 音乐进度跳转
                    await musicModel.audioPlayer.seek(
                      Duration(milliseconds: (value * duration).toInt())
                    );
                    _trackHeight = 2; // 拖动完把进度条还原
                  },
                ),
              ),
            ),
            Text(musicDate[1], style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        );
      }
    );
  }

  // 音乐控制器
  Widget _buildControl() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 17.px, horizontal: 10.px),
      child: Selector<MusicViewModel, MusicViewModel>(
        builder: (ctx, musicModel, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildPlayerMode(),
              _buildControlButton('prev', () => musicModel.baseMusicPlay(musicModel.prevMusic)),
              _buildPlayerControlButton(),
              _buildControlButton('next', () => musicModel.baseMusicPlay(musicModel.nextMusic)),
              _buildControlButton('menu', _showPlayList),
            ],
          );
        },
        selector: (ctx, musicModel) => musicModel,
        shouldRebuild: (previous, next) => false,
      ),
    );
  }

  // 音乐控制的按钮
  Widget _buildPlayerControlButton() {
    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child)  {
        bool isPlayer = musicModel.playerState == AudioPlayerState.PLAYING; // 判断是不是播放状态
        String path = isPlayer ? 'player' : 'pause'; // 获取播放/暂停对应 icon path
        Function method = isPlayer ? musicModel.pause : musicModel.resume; // 获取对应操作方法
        return _buildControlButton(path, method, size: 50);
      },
    );
  }

  // 音乐播放模式按钮
  Widget _buildPlayerMode() {
    return Consumer<MusicViewModel>(
      builder: (ctx, musicModel, child)  {
        String modePath = _getModePath(musicModel.musicPlayerMode);
        return _buildControlButton(modePath, () => musicModel.musicPlayerMode = _setMusicPlayerMode(musicModel.musicPlayerMode));
      }
    );
  }

  // 控制器的每个按钮
  Widget _buildControlButton(String icon, Function onPressed, { double size }) {
    return IconButton(
      iconSize: size ?? 24,
      icon: Image.asset(
        'assets/images/player/$icon.png',
      ),
      onPressed: onPressed,
    );
  }

  _showPlayList() {
    showGeneralDialog(
      context: context,
      barrierDismissible:true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return PlayList();
      }
    );
  }
}