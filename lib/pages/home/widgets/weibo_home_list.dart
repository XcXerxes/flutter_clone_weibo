/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 23:12:37
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 00:42:54
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/models/weiboModel.dart';
import 'package:flutter_wb_clone/pages/home/provider/home_provider.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/screen_loader.dart';
import 'package:flutter_wb_clone/widgets/weiboitem/weibo_item_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class WeiboHomeList extends StatefulWidget {
  final String mCatId;
  WeiboHomeList({@required this.mCatId = '0'});
  @override
  _WeiboHomeListState createState() => _WeiboHomeListState();
}

class _WeiboHomeListState extends State<WeiboHomeList>
    with AutomaticKeepAliveClientMixin {
  List<WeiboModel> _hotContentList = [];
  int mCurPage = 1; // 当前页数

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initData();
  }

  List<WeiboModel> jsonToModel(List list) {
    List<WeiboModel> _list = [];
    for (var i = 0; i < list.length; i++) {
      _list.add(WeiboModel.fromJson(list[i]));
    }
    return _list;
  }

  initData(int page) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      Response res = await DioManager().post(ServiceUrl.getWeiBo, {
        'catid': widget.mCatId,
        'pageNum': page,
        'pageSize': 10,
        'userId': userProvider.userInfo.id
      });
      if (res.data['status'] == 200) {
        setState(() {
          if (page == 1) {
            _hotContentList = jsonToModel(res.data['data']['list']);
          } else {
            _hotContentList.addAll(jsonToModel(res.data['data']['list']));
          }
        });
      } else {
        showToast(mCurPage == 1 ? '刷新失败' : '加载失败');
      }
    } catch (e) {
      showToast(mCurPage == 1 ? '刷新失败' : '加载失败');
    }
    // Provider.of<HomeProvider>(context, listen: false).getFeedList({
    //   'catid': '0',
    //   'pageNum': 1,
    //   'pageSize': 10,
    //   'userId': userProvider.userInfo.id
    // });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
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
      onLoad: () async {
        await initData(mCurPage + 1);
        if (mounted) {
          setState(() {
            mCurPage += 1;
          });
        }
      },
      onRefresh: () async {
        await initData(1);
        if (mounted) {
          setState(() {
            mCurPage = 1;
          });
        }
      },
      slivers: <Widget>[
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return WeiboItem(mModel: _hotContentList[index]);
        }, childCount: _hotContentList.length))
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
