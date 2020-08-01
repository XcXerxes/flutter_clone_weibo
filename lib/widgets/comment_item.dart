import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/weiboDetail.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

import '../helpers/utils.dart';
import '../helpers/utils.dart';
import '../helpers/utils.dart';
import '../routes/media_router.dart';
import '../routes/media_router.dart';
import '../routes/navigator_utils.dart';
import 'title_text.dart';
import 'title_text.dart';

class CommentItem extends StatelessWidget {

  final Comment comment;
  CommentItem(@required this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 35,
            height: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: FadeInImage(fit: BoxFit.cover,
                placeholder: AssetImage(Utils.getImageByName('img_default2.png')), image: NetworkImage(comment.fromhead),),
            ),
          ),
          Expanded(child: _buildContent(context))
        ],
      )
    );
  }

  _buildContent(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      padding: EdgeInsets.only(left: 10, bottom: 6),
      child: Column(
        children: <Widget>[
          _buildUser(),
          _buildDes(),
          _buildComment(context),
          _buildFooter()
        ],
      ),
    );
  }

  // 渲染评论
  _buildComment(context) {
    print('长度为======${comment.commentreply.length}');
    List _renderList = comment.commentreply.length > 2 ? comment.commentreply.sublist(2) : comment.commentreply;
    var list =  _renderList.map((item) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(bottom: 5),
        child: RichText(text: TextSpan(
          text: item.fromuname + ": ",
          style: TextStyle(fontSize: 12, color: Color(0xff45587E)),
          children: <TextSpan>[
            TextSpan(
              text: item.content,
              style: TextStyle(fontSize: 12, color: Color(0xff333333))
            )
          ]
        )),
      );
    }).toList();
    var _showMore;
    if(comment.commentreplynum > 2) {
      _showMore = Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: 5),
        child: InkWell(
          onTap: () {
            NavigatorUtils.push(context, '${MediaRouter.mediaCommentDetail}?comment=${Uri.encodeComponent(jsonEncode(comment))}');
          },
          child: TitleText(
            text: '共${comment.commentreply.length}条回复>',
            fontSize: 12,
            color: Color(0xff45587E),
          ),
        )
      );
      list.add(_showMore);
    }
    return Column(
      children: list,
    );
  }
  _buildUser() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TitleText(
          text: '${comment.fromuname}',
          color: comment.fromuserismember != 0 ? Color(0xffF86119) : Color(0xff636363),
          fontSize: 14,
        ),
        SizedBox(width: 4),
        comment.fromuserismember != 0 ?Image.asset(
          Utils.getImageByName('home_memeber.webp'),
          width: 15.0,
          height: 13.0,
        ): SizedBox.shrink()
      ],
    );
  }

  _buildDes() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '${comment.content}',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14
        ),
      ),
    );
  }

  _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '3-29 00:00',
          fontSize: 11,
          color: Colors.grey,
        ),
        _buildAction()
      ],
    );
  }

  _buildAction() {
    return Row(
      children: <Widget>[
        InkWell(
          child: Container(
            margin: EdgeInsets.only(right: 15),
            child: Image.asset(
              Utils.getImageByName('icon_retweet.png'),
              width: 15.0,
              height: 15.0,
            ),
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(right: 15),
            child: Image.asset(
              Utils.getImageByName('icon_comment.png'),
              width: 15.0,
              height: 15.0,
            ),
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(right: 15),
            child: Image.asset(
              Utils.getImageByName('icon_like.png'),
              width: 15.0,
              height: 15.0,
            ),
          ),
        )
      ],
    );
  }

}
