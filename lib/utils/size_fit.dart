/*
* @description: 屏幕动态适配方案
* @author：Ki
* */

import 'dart:ui';

class SizeFit {
  static double physicalWidget; // 设备物理宽度
  static double physicalHeight; // 设备物理高度
  static double screenWidth; // 设置宽度
  static double screenHeight; // 设备高度

  static double dpr; // 设备 dpr
  static double rpx; // rpx
  static double px; // px

  static initialize({ double standardSize = 750 }) {
    physicalWidget = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    dpr = window.devicePixelRatio;

    screenHeight = physicalHeight / dpr;
    screenWidth = physicalWidget / dpr;

    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

  static setRpx(double size) {
    return rpx * size;
  }

  static setPx(double size) {
    return px * size;
  }
}