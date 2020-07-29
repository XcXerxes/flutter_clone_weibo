import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/pages/media/widgets/hot_media_item.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/screen_loader.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:oktoast/oktoast.dart';

class MediaHotTabView extends StatefulWidget {
  @override
  _MediaHotTabViewState createState() => _MediaHotTabViewState();
}

class _MediaHotTabViewState extends State<MediaHotTabView> {
  int pageNum = 1;
  List<VideoModel> hotVideoList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future loadData(cPage) async {
    try {
      Response res = await DioManager()
          .post(ServiceUrl.getVideoHotList, {'pageNum': cPage, 'pageSize': 10});
      if (res.data['status'] == 200) {
        List<VideoModel> _list = [];
        res.data['data']['list'].forEach((item) {
          _list.add(VideoModel.fromJson(item));
        });
        setState(() {
          if (cPage == 1) {
            hotVideoList = _list;
            showToast('刷新成功');
          } else {
            hotVideoList.addAll(_list);
          }
        });
      }
    } catch (e) {
      print('$e');
      if (cPage == 1) {
        showToast('刷新失败：$e');
      } else {
        showToast('加载失败：$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      color: Colors.white,
      child: _buildBody(),
    );
  }

  _buildBody() {
    return EasyRefresh.custom(
      firstRefresh: true,
      firstRefreshWidget: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: ScreenLoader(
          width: 100,
          height: 100,
        ),
      ),
      header: BallPulseHeader(),
      onRefresh: () async {
        await loadData(1);
        if (mounted) {
          setState(() {
            pageNum = 1;
          });
        }
      },
      footer: BallPulseFooter(),
      onLoad: () async {
        await loadData(pageNum + 1);
        if (mounted) {
          setState(() {
            pageNum += 1;
          });
        }
      },
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _buildHotHeader(),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return HotMediaItem(hotVideoList[index]);
        }, childCount: hotVideoList.length)),
      ],
    );
  }

  /// 渲染头部
  _buildHotHeader() {
    return Container(
      child: Row(
        children: <Widget>[
          _buildHotHeaderItem('video_hot_top1.png', '排行榜'),
          _buildHotHeaderItem('video_hot_top1.png', '每周必看'),
          _buildHotHeaderItem('video_hot_type2.png', '宝藏博主'),
          _buildHotHeaderItem('video_hot_type3.png', '更多频道')
        ],
      ),
    );
  }

  /// 渲染单项
  _buildHotHeaderItem(String path, String text) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Image.asset(
            Utils.getImageByName('$path'),
            width: 45,
            height: 45,
          ),
          SizedBox(
            height: 4,
          ),
          TitleText(
            text: '$text',
            fontSize: 14,
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
