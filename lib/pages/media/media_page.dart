/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:25:20
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 02:16:58
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/pages/media/widgets/media_hot_tabview.dart';
import 'package:flutter_wb_clone/pages/media/widgets/media_recommend_tabview.dart';
import 'package:flutter_wb_clone/pages/media/widgets/media_small_tabview.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> with TickerProviderStateMixin {
  List _tabs = ['推荐', '热门', '小视频'];
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: TabBar(
            isScrollable: true,
            indicatorColor: Color(0xffffffff),
            labelColor: Color(0xffff3700),
            unselectedLabelColor: Color(0xff666666),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: _tabs
                .map((e) => Tab(
                      text: '$e',
                    ))
                .toList()),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        MediaRecommendTabView(),
        MediaHotTabView(),
        MediaSmallTabview(),
      ],
    );
  }
}
