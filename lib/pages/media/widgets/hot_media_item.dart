/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 01:13:43
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 13:46:55
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class HotMediaItem extends StatelessWidget {
  final VideoModel videoModel;
  HotMediaItem(@required this.videoModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          _buildImage(context),
          SizedBox(
            width: 10,
          ),
          _buildBody()
        ],
      ),
    );
  }

  _buildImage(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 3 / 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: FadeInImage(
                fit: BoxFit.cover,
                placeholder:
                    AssetImage(Utils.getImageByName('img_default.png')),
                image: NetworkImage(videoModel.coverimg)),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: TitleText(
            text: '0:42',
            fontSize: 14,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  /// 渲染内容
  _buildBody() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 2,
        ),
        _buildTitle(),
        _buildRecommen(),
        SizedBox(
          height: 5,
        ),
        _buildUser(),
        SizedBox(
          height: 5,
        ),
        _buildPlayNum()
      ],
    ));
  }

  /// 渲染标题
  _buildTitle() {
    return Container(
      alignment: Alignment.topLeft,
      height: 40,
      child: Text(
        '${videoModel.introduce}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  /// 渲染热门
  _buildRecommen() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(2),
        child: TitleText(
          text: '${videoModel.recommengstr}',
          fontSize: 11,
          color: Color(0xfffb9213),
        ),
        decoration: BoxDecoration(
            color: Color(0xfffef5f2),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  /// 渲染用户
  _buildUser() {
    return TitleText(
        text: '@${videoModel.username}', fontSize: 11, color: Colors.grey);
  }

  /// 渲染观看次数
  _buildPlayNum() {
    return Row(
      children: <Widget>[
        TitleText(
          text: '${videoModel.playnum}次观看',
          fontSize: 13,
          color: Colors.grey,
        ),
        SizedBox(width: 10),
        TitleText(
          text: '05-01',
          fontSize: 13,
          color: Colors.grey,
        )
      ],
    );
  }
}
