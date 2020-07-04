import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/extension/num_extension.dart';
import 'package:flutter_music/widgets/click_animation.dart';

class MusicCard extends StatelessWidget {
  final Widget centerWidget;
  final Widget bottomWidget;
  final String backgroundImgUrl;
  final Function onTab;
  Color color;

  MusicCard({ this.backgroundImgUrl, this.bottomWidget, this.centerWidget, this.onTab, this.color });

  @override
  Widget build(BuildContext context) {
    return ClickAnimation(
      onTap: onTab,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.px),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            backgroundImgUrl != null ? _buildContainer(
              child: Image.network(backgroundImgUrl, fit: BoxFit.cover)
            ) : SizedBox(),
            _buildContainer(color: color ?? Colors.black26),
            Positioned(
              child: centerWidget ?? SizedBox(),
            ),
            Positioned(
              bottom: 10,
              child: bottomWidget ?? SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  _buildContainer({ Widget child, Color color}) {
    return Container(
      width: 120.px,
      height: 150.px,
      color: color,
      child: child,
    );
  }
}