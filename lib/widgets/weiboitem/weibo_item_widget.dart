/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 23:29:10
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 12:19:54
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:flutter_wb_clone/widgets/video/weibo_video.dart';
import 'package:flutter_wb_clone/widgets/weibo/match_text.dart';
import 'package:flutter_wb_clone/widgets/weibo/parsed_text.dart';

class WeiboItem extends StatelessWidget {
  final WeiboModel mModel;
  final bool isDetail;

  WeiboItem({this.mModel, this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          _buildAuthorRow(),
          _buildTextContent(),
          _buildVideo(context),
          _buildGrid(context),
          _buildFooter()
        ],
      ),
    );
  }

  /// 渲染九宫格内容
  _buildGrid(context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var length = mModel.picurl.length;
    if (mModel.picurl != null) {
      if (length == 1) {
        return Container(
          width: screenWidth,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          child: Container(
            constraints: BoxConstraints(
                maxHeight: 250, maxWidth: 250, minHeight: 200, minWidth: 200),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.network(mModel.picurl[0], fit: BoxFit.cover),
            ),
          ),
        );
      }
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: mModel.picurl.map((picUrl) {
          return Container(
            child: Image.network(picUrl,
                fit: BoxFit.cover,
                width: (screenWidth - 40) / 3,
                height: (screenWidth - 40) / 3),
          );
        }).toList(),
      );
    }
    return SizedBox.shrink();
  }

  /// 渲染视频内容
  _buildVideo(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: (mModel.vediourl == null || mModel.vediourl.isEmpty)
          ? SizedBox.shrink()
          : Container(
              constraints: BoxConstraints(
                  maxHeight: 250,
                  maxWidth: MediaQuery.of(context).size.width,
                  minWidth: 150,
                  minHeight: 150),
              child: WeiboVideo(
                url: mModel.vediourl,
              ),
            ),
    );
  }

  /// 渲染底部收藏点赞
  _buildFooter() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Divider(),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              _buildCurrentFooter(
                  iconPath: Utils.getImageByName('ic_home_reweet.png'),
                  value: mModel.zhuanfaNum,
                  onTap: () {}),
              _buildCurrentFooter(
                  iconPath: Utils.getImageByName('ic_home_comment.webp'),
                  value: mModel.commentNum,
                  onTap: () {}),
              _buildCurrentFooter(
                  iconPath: Utils.getImageByName('ic_home_like.webp'),
                  value: mModel.likeNum,
                  onTap: () {}),
            ],
          )
        ],
      ),
    );
  }

  /// 当前的aciton
  _buildCurrentFooter({String iconPath, VoidCallback onTap, int value}) {
    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(iconPath, width: 22, height: 22),
            SizedBox(width: 4),
            TitleText(
              text: '${value}',
              color: Colors.black,
              fontSize: 13,
            )
          ],
        ),
      ),
    );
  }

  /// 渲染头像行
  Widget _buildAuthorRow() {
    return ListTile(
      leading: _buildAvatar(),
      title: _buildTitle(),
      subtitle: _buildSubTitle(),
      trailing: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(12)),
          child: TitleText(
            text: '+ 关注',
            color: Colors.orange,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  /// 渲染标题
  _buildTitle() {
    return Row(
      children: <Widget>[
        Container(
          child: TitleText(
            text: mModel.userInfo.nick,
            fontSize: 15,
            color: mModel.userInfo.ismember == 0
                ? Colors.black87
                : Color(0xffF86119),
          ),
        )
      ],
    );
  }

  /// 渲染子标题
  _buildSubTitle() {
    return Container(
      child: mModel.tail.isEmpty
          ? TitleText(
              text: mModel.userInfo.decs,
              color: Color(0xff808080),
              fontSize: 11,
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TitleText(
                  text: '${mModel.createtime}',
                  color: Color(0xff808080),
                  fontSize: 11,
                ),
                SizedBox(width: 5),
                TitleText(
                  text: '来自',
                  color: Color(0xff808080),
                  fontSize: 11,
                ),
                SizedBox(width: 5),
                Expanded(
                    child: TitleText(
                  text: mModel.tail,
                  color: Color(0xff5b77bd),
                  fontSize: 11,
                ))
              ],
            ),
    );
  }

  /// 渲染头像内容
  _buildAvatar() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(mModel.userInfo.headurl),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
              child: Image.asset(
            mModel.userInfo.isvertify == 1
                ? Utils.getImageByName('home_vertify.webp')
                : Utils.getImageByName('home_vertify2.webp'),
            width: 15,
            height: 15,
          )),
        )
      ],
    );
  }

  /// 渲染描述内容
  Widget _buildTextContent() {
    String mTextContent = mModel.content;
    if (!isDetail) {
      /// 如果字数太长 > 150
      if (mTextContent.length > 150) {
        mTextContent = mTextContent.substring(0, 148) + '...' + '全文';
      }
      mTextContent = mTextContent.replaceAll('\\n', '\n');
      return Container(
        alignment: FractionalOffset.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ParsedText(
          text: mTextContent,
          style: TextStyle(height: 1.5, fontSize: 15, color: Colors.black),
          parse: <MatchText>[
            MatchText(
                pattern: r"\[(@[^:]+):([^\]]+)\]",
                style: TextStyle(
                  color: Color(0xff5B778D),
                  fontSize: 15,
                ),
                renderText: ({String str, String pattern}) {
                  Map<String, String> map = Map<String, String>();
                  RegExp customRegExp = RegExp(pattern);
                  Match match = customRegExp.firstMatch(str);
                  map['display'] = match.group(1);
                  map['value'] = match.group(2);
                  print("正则:" + match.group(1) + "---" + match.group(2));
                  return map;
                },
                onTap: () {}),
            MatchText(
                pattern: '#.*?#',
                //       pattern: r"\B#+([\w]+)\B#",
                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                style: TextStyle(
                  color: Color(0xff5B778D),
                  fontSize: 15,
                ),
                renderText: ({String str, String pattern}) {
                  Map<String, String> map = Map<String, String>();

                  String idStr =
                      str.substring(str.indexOf(":") + 1, str.lastIndexOf("#"));
                  String showStr = str
                      .substring(str.indexOf("#"), str.lastIndexOf("#") + 1)
                      .replaceAll(":" + idStr, "");
                  map['display'] = showStr;
                  map['value'] = idStr;
                  //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

                  return map;
                },
                onTap: (String content, String contentId) async {}),
            MatchText(
              pattern: '(\\[/).*?(\\])',
              //       pattern: r"\B#+([\w]+)\B#",
              //   pattern: r"\[(#[^:]+):([^#]+)\]",
              style: TextStyle(
                fontSize: 15,
              ),
              renderText: ({String str, String pattern}) {
                Map<String, String> map = Map<String, String>();
                print("表情的正则:" + str);
                String mEmoji2 = "";
                try {
                  String mEmoji = str.replaceAll(RegExp('(\\[/)|(\\])'), "");
                  int mEmojiNew = int.parse(mEmoji);
                  mEmoji2 = String.fromCharCode(mEmojiNew);
                } on Exception catch (_) {
                  mEmoji2 = str;
                }
                map['display'] = mEmoji2;

                return map;
              },
            ),
            MatchText(
                pattern: '全文',
                //       pattern: r"\B#+([\w]+)\B#",
                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                style: TextStyle(
                  color: Color(0xff5B778D),
                  fontSize: 15,
                ),
                renderText: ({String str, String pattern}) {
                  Map<String, String> map = Map<String, String>();
                  map['display'] = '全文';
                  map['value'] = '全文';
                  return map;
                },
                onTap: (display, value) async {}),
          ],
        ),
      );
    }
  }
}
