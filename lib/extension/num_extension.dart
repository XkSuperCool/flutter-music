/*
* @description: num子类型扩展
* @author：Ki
* */

import 'package:flutter_music/utils/size_fit.dart';

extension doubleFit on double {
  double get px {
    return SizeFit.setPx(this);
  }

  double get rpx {
    return SizeFit.setRpx(this);
  }
}

extension intFit on int {
  double get px {
    return SizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return SizeFit.setRpx(this.toDouble());
  }
}
