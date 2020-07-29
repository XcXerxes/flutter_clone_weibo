/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 19:02:14
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 20:27:00
 */
import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';

import 'dart:math' as math;

import 'package:flutter_wb_clone/widgets/search/search_bar.dart';

class TopicDetailPage extends StatefulWidget {
  final String mTitle;
  final String mImg;
  final String mReadCount;
  final String mDiscussCount;
  final String mHost;

  TopicDetailPage(
      this.mTitle, this.mImg, this.mReadCount, this.mDiscussCount, this.mHost);
  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  final List<String> _tabs = ['综合', '实时', '热门', '视频', '问答', '图片', '同城'];

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
        title: SearchBar(),
      ),
      body: extended.NestedScrollView(
        pinnedHeaderSliverHeightBuilder: () {
          return 0;
        },
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: _buildTopBanner(),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 50,
                maxHeight: 50,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Color(0xffff3700),
                        indicator: UnderlineTabIndicator(
                            insets: EdgeInsets.only(bottom: 7),
                            borderSide:
                                BorderSide(color: Color(0xffff3700), width: 2)),
                        labelColor: Color(0xff333333),
                        unselectedLabelColor: Color(0xff666666),
                        labelStyle: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: TextStyle(fontSize: 16.0),
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: _tabController,
                        tabs: _tabs
                            .map((e) => Tab(
                                  text: '$e',
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      height: .5,
                      color: Color(0xffE5E5E5),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _tabs
              .map((e) => EasyRefresh(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('item$index'),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return Divider();
                        },
                        itemCount: 15),
                  ))
              .toList(),
        ),
      ),
    );
  }

  /// 渲染banner
  _buildTopBanner() {
    return Container(
      width: double.infinity,
      height: 130,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: Image.asset(
              Utils.getImageByName('topic_detail_top.webp'),
              fit: BoxFit.fill,
            ),
          ),
          _buildTopContent()
        ],
      ),
    );
  }

  /// 渲染内容
  _buildTopContent() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '# ${widget.mTitle} #',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 6),
          Text(
            '${widget.mReadCount}阅读 ${widget.mDiscussCount ?? 0}讨论 详情>',
            style: TextStyle(fontSize: 12, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Text(
            '主持人:${widget.mHost}',
            style: TextStyle(fontSize: 12, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
