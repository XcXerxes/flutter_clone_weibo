/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 16:43:08
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 16:49:03
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';

class CommitBottomTools extends StatelessWidget {
  final GestureTapCallback chooseImgTap;
  final GestureTapCallback mentionTap;
  final GestureTapCallback topicTap;
  final GestureTapCallback gifTap;
  final GestureTapCallback emotionTap;
  final GestureTapCallback addTap;

  CommitBottomTools(
      {this.chooseImgTap,
      this.mentionTap,
      this.topicTap,
      this.gifTap,
      this.emotionTap,
      this.addTap});
  @override
  Widget build(BuildContext context) {
    return _buildBottom(context);
  }

  /// 渲染底部布局
  Widget _buildBottom(context) {
    return Column(
      children: <Widget>[
        Container(
          color: Color(0xfff9f9f9),
          padding: EdgeInsets.fromLTRB(
              15, 10, 5, MediaQuery.of(context).padding.bottom + 10),
          child: Row(
            children: <Widget>[
              _buildBottomItem('icon_image.webp', chooseImgTap),
              _buildBottomItem('icon_mention.png', mentionTap),
              _buildBottomItem('icon_topic.png', topicTap),
              _buildBottomItem('icon_gif.png', gifTap),
              _buildBottomItem('icon_emotion.png', emotionTap),
              _buildBottomItem('icon_add.png', addTap),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBottomItem(String imgPath, GestureTapCallback onTap) {
    return Expanded(
      flex: 1,
      child: InkWell(
        child:
            Image.asset(Utils.getImageByName(imgPath), width: 25, height: 25),
        onTap: onTap,
      ),
    );
  }
}
