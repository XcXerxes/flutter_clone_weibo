/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 23:12:49
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 13:06:46
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/pages/home/widgets/weibo_home_list.dart';

class WeiboHotTabview extends StatefulWidget {
  @override
  _WeiboHotTabviewState createState() => _WeiboHotTabviewState();
}

class _WeiboHotTabviewState extends State<WeiboHotTabview> {
  List<String> _tabs = ['推荐', '附近', '榜单', '明星', '搞笑', '社会', '测试'];
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: _tabs.length, vsync: ScrollableState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        _buildTabbar(),
        Expanded(
          child: _buildTabView(),
        )
      ],
    ));
  }

  _buildTabbar() {
    return TabBar(
      tabs: _tabs
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
      isScrollable: true,
      indicatorColor: Color(0xffffffff),
      labelColor: Color(0xffff3700),
      unselectedLabelColor: Color(0xff666666),
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 16),
      indicatorSize: TabBarIndicatorSize.label,
      controller: _controller,
    );
  }

  _buildTabView() {
    return TabBarView(
      controller: _controller,
      children: <Widget>[
        WeiboHomeList(mCatId: '1'),
        WeiboHomeList(mCatId: '2'),
        WeiboHomeList(mCatId: '3'),
        WeiboHomeList(mCatId: '4'),
        WeiboHomeList(mCatId: '5'),
        Center(
          child: Text('暂无数据'),
        ),
        WeiboHomeList(mCatId: '10')
      ],
    );
  }
}
