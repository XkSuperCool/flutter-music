# flutter_music

Flutter 仿iOS网易云项目，项目只完成了一部分，后面会慢慢完成，接口使用 [NeteaseCloudMusicApi](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=neteasecloudmusicapi) 感谢。

## 第三方框架

|         库         |       功能        |
| :----------------: | :---------------: |
|   flutter_swiper   |     轮播部件      |
|        dio         |     网络框架      |
|    audioplayers    |     音频播放      |
|      provider      |     状态管理      |
|  pull_to_refresh   | 上拉加载/下拉刷新 |
| shared_preferences |     本地存储      |
|     fijkplayer     |     视频播放      |

## 使用

​	注：本项目接口使用 [NeteaseCloudMusicApi](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=neteasecloudmusicapi) 所以需要先在本地运行该 node 服务，然后在控制台输入 `ipconfig` 查看本机 ip 地址，再到 utils -> http_request.dart 文件中修改 baseUrl = ip地址:node端口，如：

`baseUrl = http://192.168.0.153:8989`

```
// flutter 版本 1.17.1
$ flutter packages get
$ flutter run
```

## 实现页面

- [x] 首页展示
- [x] 歌单详情
- [x] 歌单广场
- [x] 视频页面
- [x] 推荐音乐
- [x] 手机登录
- [x] 播放页面
- [x] 我的页面

## 实现功能

* 音乐播放/暂停
* 音乐切换（上一首/下一首）
* 音乐播放模式（随机/列表循环/单曲循环）
* 音乐播放进度条
* 拖动进度条移动播放时间
* 播放列表
* 歌词滚动
* 封面旋转动画
* 视频播放
* 手机号登录
* 用户歌单

...等细节

## 截图

<figure class="third">
    <img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680474.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680486.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680501.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680692.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680696.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680792.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680830.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680830.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680839.png' width='200'>
<img src='https://raw.githubusercontent.com/XkSuperCool/flutter-music/master/screenshot/Screenshot_1593680845.png' width='200'>
<img src='https://github.com/XkSuperCool/flutter-music/blob/master/screenshot/Screenshot_1593680871.png?raw=true' width='200'>
<img src='https://github.com/XkSuperCool/flutter-music/blob/master/screenshot/Screenshot_1593681039.png?raw=true' width='200'>
<img src='https://github.com/XkSuperCool/flutter-music/blob/master/screenshot/Screenshot_1593846778.png?raw=true' width='200'>
</figure>