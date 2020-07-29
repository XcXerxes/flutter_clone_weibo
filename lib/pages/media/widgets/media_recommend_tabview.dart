/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 21:20:18
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 02:23:57
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/pages/media/widgets/media_item.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/screen_loader.dart';
import 'package:oktoast/oktoast.dart';

class MediaRecommendTabView extends StatefulWidget {
  @override
  _MediaRecommendTabViewState createState() => _MediaRecommendTabViewState();
}

class _MediaRecommendTabViewState extends State<MediaRecommendTabView>
    with AutomaticKeepAliveClientMixin {
  int pageNum = 1;
  List<VideoModel> videoList = [];
  @override
  void initState() {
    // TODO: implement initState
    // fetchData();
    super.initState();
  }

  Future fetchData(int cPage) async {
    try {
      Response res = await DioManager().post(
          ServiceUrl.getVideoRecommendList, {'pageNum': cPage, 'pageSize': 10});
      if (res.data['status'] == 200) {
        List<VideoModel> _list = [];
        res.data['data']['list'].forEach((item) {
          _list.add(VideoModel.fromJson(item));
        });
        setState(() {
          if (cPage == 1) {
            videoList = _list;
          } else {
            videoList.addAll(_list);
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
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: EasyRefresh.custom(
        firstRefresh: true,
        firstRefreshWidget: Container(
          width: double.infinity,
          height: double.infinity,
          child: ScreenLoader(
            backgroundColor: Colors.white,
          ),
        ),
        header: BallPulseHeader(),
        onRefresh: () async {
          await fetchData(1).then((_) {
            if (mounted) {
              setState(() {
                pageNum = 1;
              });
            }
          });
        },
        footer: BallPulseFooter(),
        onLoad: () async {
          print('loading------------');
          await fetchData(pageNum + 1).then((_) {
            if (mounted) {
              setState(() {
                pageNum += 1;
              });
            }
          });
        },
        slivers: videoList.length > 0
            ? <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: (size.width / 2) / 200,
                      crossAxisCount: 2),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return MediaItem(videoModel: videoList[index]);
                  }, childCount: videoList.length),
                )
              ]
            : [],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
