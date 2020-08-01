import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/models/weiboDetail.dart';

import '../../helpers/utils.dart';
import '../../services/api.dart';
import '../../services/request.dart';
import '../../widgets/screen_loader.dart';
import '../../widgets/title_text.dart';

class MediaCommentDetailPage extends StatefulWidget {
  final Comment comment;
  MediaCommentDetailPage(@required this.comment);
  @override
  _MediaCommentDetailPageState createState() => _MediaCommentDetailPageState();
}

class _MediaCommentDetailPageState extends State<MediaCommentDetailPage> {
  List<Comment> commentList = [];
  int pageNum = 1;

  loadData(int page) async {
    try{
      Response res = await DioManager().post(ServiceUrl.getWeiBoCommentReplyList, {
        'commentid': widget.comment.commentid,
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('评论详情'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return EasyRefresh.custom(
      header: BallPulseHeader(),
      footer: BallPulseFooter(),
      onRefresh: () async {
        await loadData(1);
        if(mounted) {
          setState(() {
            pageNum = 1;
          });
        }
      },
      onLoad: () async {
        await loadData(pageNum + 1);
        if(mounted) {
          setState(() {
            pageNum += 1;
          });
        }
      },
      firstRefresh: true,
      firstRefreshWidget: Container(
        width: double.infinity,
        height: double.infinity,
        child: ScreenLoader(),
      ),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(padding: EdgeInsets.only(top: 10, bottom: 20),
            child: _buildHeader(widget.comment, isTop: true),)
        ),
        SliverToBoxAdapter(
          child: _buildTitle(),
        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, i) {
          return _buildCommentItem(commentList[i]);
        }, childCount: commentList.length))
      ],
    );
  }
  _buildCommentItem(Comment currentMomment) {
    return _buildHeader(currentMomment);
  }
  /// 过滤
  _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.only(left: 50, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1
          )
        )
      ),
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
  _buildHeader(Comment comment, {bool isTop = false}) {
    double pding = isTop ? 15 : 20;
    return Container(
      padding: EdgeInsets.only(left: pding, right: 15),
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
            Expanded(child: _buildHeaderContent(comment, isToop: isTop)),
            _buildTool(isTop)
          ],
        )
    );
  }
  _buildHeaderContent(Comment comment, {bool isToop = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 10, bottom: 6),
      child: Column(
        children: <Widget>[
          _buildUser(comment),
          _buildDes(comment),
          !isToop ? Divider() : SizedBox.shrink()
        ],
      ),
    );
  }

  _buildUser(Comment comment) {
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

  _buildDes(Comment comment) {
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

  _buildTool(bool isTop) {
    return Row(
      children: <Widget>[
        Image.asset(Utils.getImageByName('icon_like.png'), width: 15, height: 15,),
        SizedBox(width: 10,),
        Visibility(
          visible: isTop,
          child: Image.asset(Utils.getImageByName('icon_comment.png'), width: 15, height: 15,),
        )
      ],
    );
  }
}
