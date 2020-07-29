/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 23:12:37
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 13:04:27
 */
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/pages/home/provider/home_provider.dart';
import 'package:flutter_wb_clone/pages/home/widgets/weibo_home_list.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/widgets/weiboitem/weibo_item_widget.dart';
import 'package:provider/provider.dart';

class WeiboFollowTabview extends StatefulWidget {
  @override
  _WeiboFollowTabviewState createState() => _WeiboFollowTabviewState();
}

class _WeiboFollowTabviewState extends State<WeiboFollowTabview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    Provider.of<HomeProvider>(context, listen: false).getFeedList({
      'catid': '0',
      'pageNum': 1,
      'pageSize': 10,
      'userId': userProvider.userInfo.id
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeiboHomeList(mCatId: '0');
  }
}
