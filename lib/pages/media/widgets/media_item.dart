/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 22:44:40
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 00:13:27
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/routes/application.dart';
import 'package:flutter_wb_clone/routes/media_router.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class MediaItem extends StatelessWidget {
  final VideoModel videoModel;
  MediaItem({this.videoModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtils.push(context, '${MediaRouter.mediaDetail}?video=${Uri.encodeComponent(jsonEncode(videoModel))}');
      },
      child: Container(
        child: Column(
          children: <Widget>[_buildMeida(context), _buildFooter()],
        ),
      ),
    );
  }

  /// 渲染视频
  _buildMeida(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Stack(
        children: <Widget>[_buildMediaImage(context), _buildMediaTool()],
      ),
    );
  }

  /// 渲染视频图片
  _buildMediaImage(context) {
    return Container(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage(Utils.getImageByName('img_default2.png')),
          image: NetworkImage(videoModel.coverimg),
        ),
      ),
    );
  }

  /// 渲染视频的tool
  _buildMediaTool() {
    return Positioned(
        bottom: 5,
        left: 5,
        right: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  Utils.getImageByName('video_play.png'),
                  width: 15,
                  height: 15,
                ),
                SizedBox(
                  width: 4,
                ),
                TitleText(
                  text: '${videoModel.playnum}',
                  fontSize: 14,
                  color: Colors.white,
                )
              ],
            ),
            TitleText(
              text: '5:41',
              color: Colors.white,
              fontSize: 14,
            )
          ],
        ));
  }

  /// 渲染内容
  _buildFooter() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 2, right: 2),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            height: 40,
            child: Text(
              '${videoModel.introduce}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          SizedBox(height: 6),
          _buildTag()
        ],
      ),
    );
  }

  _buildTag() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildCTag(),
        InkWell(
          child: Image.asset(
            Utils.getImageByName('video_ver_more.png'),
            width: 15,
            height: 15,
          ),
        )
      ],
    );
  }

  _buildCTag() {
    return videoModel.recommengstr.isEmpty
        ? videoModel.tag.isEmpty
            ? SizedBox.shrink()
            : TitleText(
                text: videoModel.tag.toString(),
                fontSize: 12,
                color: Colors.black87,
              )
        : Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Color(0xfffef5e2)),
            child: TitleText(
              text: '点赞飙升',
              fontSize: 11,
              color: Colors.orange,
            ),
          );
  }
}
