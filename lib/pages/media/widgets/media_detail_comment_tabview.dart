import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/weiboDetail.dart';
import 'package:flutter_wb_clone/widgets/comment_item.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

import '../../../services/api.dart';
import '../../../services/request.dart';
import '../../../widgets/screen_loader.dart';


class MediaDetailCommentTabview extends StatefulWidget {
  @override
  _MediaDetailCommentTabviewState createState() => _MediaDetailCommentTabviewState();
}

class _MediaDetailCommentTabviewState extends State<MediaDetailCommentTabview> {

  List<Comment> commentList = [];
  int pageNum = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loadData(int page) async {
    try{
      Response res = await DioManager().post(ServiceUrl.getWeiBoDetailComment, {
        'weiboid': '1',
        'pageSize': 10,
        'pageNum': page
      });
      print("输出内容为======${res.data}");
      if(res.data['status'] == 200) {
        List<Comment> _list = [];
        res.data['data']['list'].forEach((item) {
          _list.add(Comment.fromJson(item));
        });
        if(page == 1) {
          setState(() {
            commentList = _list;
          });
        } else {
          setState(() {
            commentList.addAll(_list);
          });
        }
      }
    }catch(e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      onRefresh: () async {
        await loadData(1);
        if(mounted) {
          setState(() {
            pageNum = 1;
          });
        }
      },
      header: BallPulseHeader(),
      firstRefresh: true,
      firstRefreshWidget: Container(
        width: double.infinity,
        height: double.infinity,
        child: ScreenLoader(),
      ),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _buildTitle(),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(delegate: SliverChildBuilderDelegate((context, i) {
            return CommentItem(commentList[i]);
          }, childCount: commentList.length)),
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
