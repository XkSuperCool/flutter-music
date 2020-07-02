import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'music_cover_progress.dart';
import 'package:flutter_music/extension/num_extension.dart';

class MusicHeader extends StatefulWidget {
  final Widget title; // 标题
  final Widget leftWidget;
  final Widget rightWidget;
  final Color color; // 背景颜色
  final Color leftWidgetColor;

  MusicHeader({
    this.title,
    this.leftWidget,
    this.rightWidget,
    this.color,
    this.leftWidgetColor
  });

  @override
  MusicHeaderState createState() => MusicHeaderState();
}

class MusicHeaderState extends State<MusicHeader> {
  bool _isFocus = false; // 是否聚焦
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // 失去焦点
        setState(() => _isFocus = false);
      } else {
        // 获得焦点
        setState(() => _isFocus = true);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: widget.color ?? Colors.white,
        child: Row(
          children: <Widget>[
            widget.leftWidget ?? IconButton(
              color: widget.leftWidgetColor,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: widget.title ?? _buildInput()
            ),
            widget.rightWidget ?? MusicCoverProgress()
          ],
        ),
      ),
    );
  }

  // 输入框
  Widget _buildInput() {
    return Container(
      height: 35.px,
      child: TextField(
        maxLines: 1,
        focusNode: _focusNode,
        textAlign: _isFocus ? TextAlign.start : TextAlign.center,
        decoration: InputDecoration(
          fillColor: Color(0x30cccccc),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.px),
          prefixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00FF0000)),
            borderRadius: BorderRadius.all(Radius.circular(100.px))
          ),
          hintText: '湘湖浪子 - Ranzer',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00FF0000)),
            borderRadius: BorderRadius.all(Radius.circular(100.px))
          )
        ),
      ),
    );
  }
}