import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/widgets/comment_item.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class MediaDetailCommentTabview extends StatefulWidget {
  @override
  _MediaDetailCommentTabviewState createState() => _MediaDetailCommentTabviewState();
}

class _MediaDetailCommentTabviewState extends State<MediaDetailCommentTabview> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _buildTitle(),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(delegate: SliverChildBuilderDelegate((context, i) {
            return CommentItem();
          }, childCount: 10)),
        )
      ],
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(
            Utils.getImageByName('weibo_comment_shaixuan.png'),
            width: 15.0,
            height: 17.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: TitleText(
              text: '按热度',
              color: Colors.grey,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
