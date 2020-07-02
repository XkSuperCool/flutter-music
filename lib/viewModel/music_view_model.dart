import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/model/musicProviderModel/current_music.dart';
import 'package:flutter_music/model/musicProviderModel/music_item_model.dart';
import 'package:flutter_music/model/musicProviderModel/check_music.dart';
import 'package:flutter_music/servives/music_provider_api.dart';

enum MusicPlayerMode {
  SingleCycle, // 单曲循环
  ListCycle, // 列表循环
  RandomPlayer // 随机播放
}

class MusicViewModel extends ChangeNotifier {
  AudioPlayer _audioPlayer;
  MusicItemModel _currentPlayerMusicItem; // 当前播放的音乐项，包含具体信息
  String _currentMusicUrl; // 当前播放歌曲的 url
  double _progress = 0.0; // 当前歌曲的播放进度
  int  _musicDuration; // 音乐播放总时长
  bool _flag = false; // 锁，控制在监听状态时是否同步 _progress， false 解锁（不控制）， true上锁（控制）
  AudioPlayerState _playerState; // 音乐播放状态
  MusicPlayerMode _musicPlayerMode = MusicPlayerMode.ListCycle; // 播放方式
  List<MusicItemModel> _musicList = []; // 当前播放的音乐列表

  MusicViewModel() {
    // AudioPlayer.logEnabled = true; // 开发环境，启用日志，方便调试
    _audioPlayer = AudioPlayer(); // 初始化音频播放控制器

    // 音乐播放状态监听，制作进度条
    _audioPlayer.onAudioPositionChanged.listen((Duration  p) async {
      if (_flag) return; // 如果处于拖动改变进度时，下面不触发
      int currentPosition = await _audioPlayer.getCurrentPosition(); // 获取当前音乐播放时长
      _musicDuration = await _audioPlayer.getDuration(); // 获取总时长并保存
      double ratio = currentPosition / _musicDuration; // 计算当前播放的比例
      _progress = ratio > 1 ? 1: ratio; // 保存播放进度
      notifyListeners();
    });

    // 监听音乐是在播放还是暂停
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      _playerState = s;
      notifyListeners();
    });

    // 监听播放结束，处理下面该怎么播放
    _audioPlayer.onPlayerCompletion.listen((event) async {
      if (_musicPlayerMode == MusicPlayerMode.ListCycle) {
        baseMusicPlay(_listCycle);
      } else if (_musicPlayerMode == MusicPlayerMode.SingleCycle) {
        resume();
      } else if (_musicPlayerMode == MusicPlayerMode.RandomPlayer) {
        baseMusicPlay(_randomPlayer);
      }
    });
  }

  // 歌曲无法播放时的错误提示
  _errorDialog({ String message }) {
    // TODO: 全局弹框，未做
  }

  /*
  * 根据 id 获取音乐信息并播放
  * return bool 是否正常播放
  * */
  Future<bool> getPlayMusic(MusicItemModel musicItem) async {
    // 如果点击播放的音乐是当前播放的音乐，不在继续往下执行
    if (_currentPlayerMusicItem != null && musicItem.id == _currentPlayerMusicItem.id) {
      // TODO: 如果是当前播放音乐，处于正常播放状态，返回 true
      return true;
    }

    // 判断音乐是否可用
    CheckMusicModel check = await MusicProviderApi.checkMusic(musicItem.id);
    if (check == null || !check.success) {
      _errorDialog(message: check?.message);
      return false;
    }

    // 获取音乐 url
    CurrentMusicModel music = await MusicProviderApi.getPlayMusic(musicItem.id);

    if (music?.url == null) {
      _errorDialog();
      return false;
    }

    // 停止当前播放的音乐
    await _audioPlayer.stop();

    // 设置为当前播放音乐并播放
    _currentMusicUrl = music.url;
    currentPlayerMusicItem = musicItem;
    await player();
    // 如果当前播放的音乐不在播放列表中的话，则加入到列表中
    if (_musicList.indexOf(musicItem) == -1) {
      musicList.add(musicItem);
    }

    return true;
  }

  // TODO：触发播放模式的基础方法，列表播放/随机播放/播放上一首/播放下一首，都传递到此函数中进行触发
  // TODO： 此函数的作用为判断歌曲列表是不是只有一首歌，让其可以重复播放
  void baseMusicPlay(Function fun) async {
    // TODO: 如果列表项只有一个时，使用 resume() 实现继续播放, 因为 play 播放完一首歌接续播放同一首时会处于暂停态
    if (_musicList.length == 1) {
      resume();
      return;
    }

    await fun();
  }

  // 列表播放
  void _listCycle() async {
    // 获取当前播放音乐在播放列表中的 index
    int index = _musicList.indexWhere((i) => i.id == _currentPlayerMusicItem.id);
    // 判断是否存在于播放列表中
    if (index != -1) {
      // 不是最后一首歌则播放下一首
      if (index != _musicList.length - 1) {
        await getPlayMusic(_musicList[index + 1]);
      } else {
        // 是最后一个歌就播放第一首
        await getPlayMusic(_musicList[0]);
      }
    }
  }

  // 随机播放
  void _randomPlayer() async {
    int length = _musicList.length; // 获取音乐列表总长度
    int randomIndex = Random().nextInt(length - 1); // 获取随机下标
    MusicItemModel randomMusic = _musicList[randomIndex]; // 获取对应音乐

    if (randomMusic.id == _currentPlayerMusicItem.id) {
      // 随机到重复项，重新播放
      await resume();
    } else {
      // 未重复，播放随机到的音乐
      await getPlayMusic(_musicList[randomIndex]);
    }
  }

  // 播放上一首
  void prevMusic() async {
    // 获取当前播放音乐在播放列表中的 index
    int index = _musicList.indexWhere((i) => i.id == _currentPlayerMusicItem.id);
    if (index == 0) {
      // 如果是第一首播放最后一首
      await getPlayMusic(_musicList[_musicList.length - 1]);
    } else {
      await getPlayMusic(_musicList[index - 1]);
    }
  }

  // 播放下一首
  void nextMusic() async {
    // 获取当前播放音乐在播放列表中的 index
    int index = _musicList.indexWhere((i) => i.id == _currentPlayerMusicItem.id);
    if (index == _musicList.length - 1) {
      // 如果是最后一首播放最后一首
      await getPlayMusic(_musicList[0]);
    } else {
      await getPlayMusic(_musicList[index + 1]);
    }
  }

  // 播放音乐
  player() async {
    await _audioPlayer.play(_currentMusicUrl);
  }

  // 继续播放
  resume() async {
    await _audioPlayer.resume();
  }

  // 暂停音乐
  pause() async {
    await _audioPlayer.pause();
  }

  AudioPlayer get audioPlayer => _audioPlayer;

  // 获取当前播放音乐项
  MusicItemModel get currentPlayerMusicItem => _currentPlayerMusicItem;

  // 获取播放进度
  num get progress => _progress;

  // 获取音乐播放总时长
  int get musicDuration => _musicDuration;

  // 获取播放模式
  MusicPlayerMode get musicPlayerMode => _musicPlayerMode;

  // 获取播放状态
  AudioPlayerState get playerState => _playerState;

  // 设置当前播放
  set currentPlayerMusicItem(MusicItemModel music) {
    _currentPlayerMusicItem = music;
    notifyListeners();
  }

  // 设置播放模式
  set musicPlayerMode(MusicPlayerMode mode) {
    _musicPlayerMode = mode;
    notifyListeners();
  }

  // 设置播放进度
  set progress(num value) {
    _progress = value;
    notifyListeners();
  }

  // 设置状态通过锁
  set flag(bool boolean) {
    _flag = boolean;
  }

  // 设置播放歌单
  set musicList(List<MusicItemModel> songList) {
    _musicList = songList;
    notifyListeners();
  }

  // 获取播放歌单
  List<MusicItemModel> get musicList => _musicList;
}