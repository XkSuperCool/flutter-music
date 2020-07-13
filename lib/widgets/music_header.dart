import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/model/searchModel/hot_search.dart';
import 'package:flutter_music/services/search_api.dart';

import 'music_cover_progress.dart';
import 'package:flutter_music/pages/search/search.dart';
import 'package:flutter_music/extension/num_extension.dart';

class MusicHeader extends StatefulWidget {
  final Widget title; // 标题 中间 widget
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
  bool _enterSearch = false;
  FocusNode _focusNode = FocusNode();
  List<HotSearchModel> _hotSearch = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // 获取热搜
  _getHotSearch() async {
    _hotSearch = await SearchApi.getHotSearch();
    setState(() {});
  }

  // 跳转搜索
  _jumpSearch(BuildContext context, String searchKey) {
    Navigator.of(context).pushNamed(SearchPage.routerName, arguments: searchKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color ?? Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SafeArea(
            child: Container(
              color: widget.color ?? Colors.white,
              child: Row(
                children: <Widget>[
                  _enterSearch ? SizedBox(
                    width: 15.px,
                    height: 43.px,
                  ) : widget.leftWidget ?? IconButton(
                    color: widget.leftWidgetColor,
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: widget.title ?? _buildInput()
                  ),
                  _enterSearch ? GestureDetector(
                    onTap: () {
                      _enterSearch = false;
                      _textEditingController.clear();
                      // TODO: 隐藏键盘
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.px, right: 15.px),
                      child: Text('取消', style: TextStyle(fontSize: 14.px)),
                    ),
                  ) : widget.rightWidget ?? MusicCoverProgress()
                ],
              ),
            ),
          ),
          if (_enterSearch) Expanded(
            child: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _buildTitle('搜索历史'),
                        _buildHistorySearch(),
                        _buildTitle('热搜榜'),
                        SizedBox(height: 10.px)
                      ]
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) => _buildHotSearchList(index),
                      childCount: _hotSearch.length
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4.5,
                      mainAxisSpacing: 10.px
                    )
                  )
                ],
              ),
            ),
          ) else SizedBox()
        ],
      ),
    );
  }

  // 输入框
  Widget _buildInput() {
    return GestureDetector(
      onTap: () {
        _enterSearch = true;
        _getHotSearch();
        setState(() {});
      },
      child: Container(
        height: 35.px,
        child: !_enterSearch ? Container(
          padding: EdgeInsets.symmetric(horizontal: 10.px),
          decoration: BoxDecoration(
            color: Color(0x30cccccc),
            borderRadius: BorderRadius.all(Radius.circular(100.px))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search, color: Color.fromRGBO(140, 140, 140, 1)),
              SizedBox(width: 10.px),
              Text('湘湖浪子 - Ranzer', style: TextStyle(
                color: Color.fromRGBO(140, 140, 140, 1),
                fontSize: 14.px
              ))
            ],
          ),
        ): TextField(
          onSubmitted: (value) => _jumpSearch(context, value),
          controller: _textEditingController,
          maxLines: 1,
          autofocus: true,
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
      ),
    );
  }

  // Title
  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 10.px) ,
      child: Text('$title', style: TextStyle(
        fontWeight: FontWeight.bold
      )),
    );
  }

  // 历史搜索
  Widget _buildHistorySearch() {
    List<String> history = ['热的冒烟', '艺术家', '以下范上', '火苗', '楼梯', '天上的星星不说话'];
    return Container(
      height: 40.px,
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.px),
          child: RawChip(
            onPressed: () => _jumpSearch(context, '${ history[index] }'),
            backgroundColor: Color.fromRGBO(242, 242, 242, 1),
            label: Text(history[index], style: TextStyle(fontSize: 12.px)),
          ),
        ),
        itemCount: history.length,
      ),
    );
  }

  // 热搜
  Widget _buildHotSearchList(int index) {
    return  GestureDetector(
      onTap: () => _jumpSearch(context, _hotSearch[index].searchWord),
      child: Padding(
        padding: EdgeInsets.only(left: 10.px),
        child: Row(
          children: <Widget>[
            Text('${ index + 1 }', style: TextStyle(
              color: index < 4 ? Colors.red : Colors.grey,
              fontSize: 16.px,
              fontWeight: FontWeight.bold
            )),
            SizedBox(width: 6.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(_hotSearch[index].searchWord, style: TextStyle(
                        fontWeight: index < 4 ? FontWeight.bold : FontWeight.normal
                      )),
                      SizedBox(width: 5.px),
                      _hotSearch[index].iconUrl != null ? Image.network(_hotSearch[index].iconUrl, width: 30.px, height: 15.px,): SizedBox()
                    ],
                  ),
                  Expanded(
                    child: Text(_hotSearch[index].content, style: TextStyle(
                      fontSize: 11.px,
                    ), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}