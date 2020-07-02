import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClickAnimation extends StatefulWidget {
  final Widget child;
  final Function onTap;

  ClickAnimation({ @required this.child , this.onTap });

  @override
  ClickAnimationState createState() => ClickAnimationState();
}

class ClickAnimationState extends State<ClickAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _tweenAnimation;
  Animation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    // 100ms 动画时间
    _controller = AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad);
    _tweenAnimation = Tween(begin: 1.0, end: 0.97).animate(_curvedAnimation);

    _tweenAnimation.addStatusListener((status) {
      // 动画完成后，反转执行画
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.onTap != null) widget.onTap(); // 执行传递的事件
        // 点击后执行缩小动画
        _controller.forward();
      },
      child: AnimatedBuilder(
        animation: _tweenAnimation,
        builder: (ctx, child) {
          return Transform.scale(
            scale: _tweenAnimation.value,
            child: widget.child
          );
        },
      )
    );
  }
}