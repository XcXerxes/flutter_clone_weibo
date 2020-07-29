/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 01:56:13
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 14:09:25
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/screen_loader.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:oktoast/oktoast.dart';

class MediaSmallTabview extends StatefulWidget {
  @override
  _MediaSmallTabviewState createState() => _MediaSmallTabviewState();
}

class _MediaSmallTabviewState extends State<MediaSmallTabview> {
  int pageNum = 1;

  List<VideoModel> smallVideoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future loadData(cPage) async {
    try {
      Response res = await DioManager().post(
          ServiceUrl.getVideoSmallList, {'pageNum': cPage, 'pageSize': 10});
      if (res.data['status'] == 200) {
        List<VideoModel> _list = [];
        res.data['data']['list'].forEach((item) {
          _list.add(VideoModel.fromJson(item));
        });
        setState(() {
          if (cPage == 1) {
            smallVideoList = _list;
            showToast('刷新成功');
          } else {
            smallVideoList.addAll(_list);
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
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: EasyRefresh(
          firstRefresh: true,
          firstRefreshWidget: Container(
            width: double.infinity,
            height: double.infinity,
            child: ScreenLoader(
              width: 100,
              height: 100,
            ),
          ),
          header: BallPulseHeader(),
          footer: BallPulseFooter(),
          onRefresh: () async {
            await loadData(1);
            if (mounted) {
              setState(() {
                pageNum = 1;
              });
            }
          },
          onLoad: () async {
            await loadData(pageNum + 1);
            if (mounted) {
              setState(() {
                pageNum += 1;
              });
            }
          },
          child: smallVideoList.length > 0
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 2),
                  itemBuilder: (BuildContext context, int index) {
                    VideoModel videoModel = smallVideoList[index];
                    return InkWell(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            child: ClipRRect(
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: AssetImage(
                                    Utils.getImageByName('img_default2.png')),
                                image: NetworkImage(videoModel.coverimg),
                              ),
                            ),
                          ),
                          _buildRow(videoModel)
                        ],
                      ),
                    );
                  },
                  itemCount: smallVideoList.length)
              : Container()),
    );
  }

  _buildRow(VideoModel vModel) {
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
                  text: '${vModel.playnum}',
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
}
