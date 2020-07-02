import 'package:flutter/cupertino.dart';

class RotateAnimation extends StatefulWidget {
  final Widget child;
  final bool rotate;

  RotateAnimation({ @required this.child, this.rotate = false });

  @override
  RotateAnimationState createState() => RotateAnimationState();
}

class RotateAnimationState extends State<RotateAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _curvedAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 8), vsync: this);
    _curvedAnim = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _curvedAnim.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
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
    if (widget.rotate) _controller.forward();
    else _controller.stop();

    return RotationTransition(
      //设置动画的旋转中心
      alignment: Alignment.center,
      //动画控制器
      turns: _curvedAnim,
      //将要执行动画的子view
      child: widget.child,
    );
  }
}