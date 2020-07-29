import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/pages/media/widgets/hot_media_item.dart';
import 'package:flutter_wb_clone/pages/media/widgets/media_item.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class MediaDetailIntroTabview extends StatefulWidget {
  final VideoModel videoModel;
  MediaDetailIntroTabview(@required this.videoModel);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MediaDetailIntroTabviewState();
  }
}

class _MediaDetailIntroTabviewState extends State<MediaDetailIntroTabview> {

  List<VideoModel> recommendList = [];

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  loadData() async{
    try {
      Response res = await DioManager().post(ServiceUrl.getVideoDetailRecommendList, {
        'videoid': widget.videoModel.id
      });
      if(res.data['status'] == 200) {
        recommendList.clear();
        res.data['data'].forEach((item) {
          recommendList.add(VideoModel.fromJson(item));
        });
        setState(() {

        });
      }
    }catch(e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(slivers: [
      SliverToBoxAdapter(
        child: _buildInfo()
      ),
      SliverToBoxAdapter(
        child: _videoHeader(),
      ),
      SliverPadding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return HotMediaItem(recommendList[index]);
          }, childCount: recommendList.length),
        ),
      )
    ]);
  }

  _buildInfo() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildUser(),
          _buildAction(),
          SizedBox(height: 12),
          Divider(height: 1)
        ],
      ),
    );
  }

  /// 视频信息
  _buildUser() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.videoModel.userheadurl),
          ),
          title: Row(
            children: <Widget>[
              TitleText(
                text: '${widget.videoModel.username}',
                fontSize: 18,
              ),
              Container(
                margin: EdgeInsets.only(left: 6),
                padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                child: TitleText(text: '作者', fontSize: 10),
              )
            ],
          ),
          subtitle: TitleText(
            text: '${widget.videoModel.userfancount}粉丝 视频博主',
            fontSize: 12,
            color: Colors.grey,
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange, width: 1)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add, color: Colors.orange,size: 16,),
                TitleText(
                  text: '关注',
                  color: Colors.orange,
                  fontSize: 14,
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 15),
          child: TitleText(
            text: '${widget.videoModel.introduce}',
            fontSize: 16,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Row(
            children: <Widget>[
              TitleText(
                text: '${widget.videoModel.createtime}',
                fontSize: 12,
                color: Colors.grey,
              ),
              SizedBox(width: 15),
              TitleText(
                text: '${widget.videoModel.playnum}次观看',
                fontSize: 12,
                color: Colors.grey,
              )
            ],
          ),
        )
      ],
    );
  }
  /// 动作
  _buildAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildActionItem('video_detail_zhuanfa.png', '转发'),
        _buildActionItem('video_detail_zan.png', '点赞'),
        _buildActionItem('video_detail_share.png', '分享'),
        _buildActionItem('video_detail_downlaod.png', '下载'),
      ],
    );
  }

  _buildActionItem(String url, String text) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Image.asset(Utils.getImageByName('$url'), width: 25, height: 25,),
          SizedBox(height: 5),
          TitleText(
            text: '$text',
            fontSize: 14,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  /// 视频头部
  _videoHeader() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleText(
            text: '接下来播放',
            fontSize: 16,
          ),
          Row(
            children: <Widget>[
              TitleText(
                text: '自动播放',
                fontSize: 16,
              ),
              Switch(value: false, onChanged: (bool value) {

              })
            ],
          )
        ],
      ),
    );
  }
}
