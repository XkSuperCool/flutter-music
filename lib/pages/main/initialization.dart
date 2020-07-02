import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_music/extension/num_extension.dart';

/*
* 生成底部导航栏对应数组
* */
List<BottomNavigationBarItem> buildBottomNavigationBarItems(int currentIndex) {
  return [
    buildBottomNavigationBarItem('发现', 'discover', 'discover_active'),
    buildBottomNavigationBarItem('视频', 'video', 'video_active'),
    buildBottomNavigationBarItem('我的', 'my', 'my_active'),
    buildBottomNavigationBarItem('云村', 'cloud', 'cloud_active'),
    buildBottomNavigationBarItem('账号', 'account', 'account_active')
  ];
}

/*
* 生成底部导航每一项
* @ title： 标题名称
* @ imageName：图标名称
* @ activeImgName：高亮的图标名称
* */
BottomNavigationBarItem buildBottomNavigationBarItem(String title, String imageName, String activeImgName) {
  return BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/home/icon_$imageName.png',
      width: 21.px,
      height: 21.px,
    ),
    activeIcon: Image.asset(
      'assets/images/home/icon_$activeImgName.png',
      width: 21.px,
      height: 21.px,
    ),
    title: Text(title, style: TextStyle(color: Colors.black)),
  );
}