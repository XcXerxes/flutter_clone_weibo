/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:24:42
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 18:46:10
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/findHomeModel.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/pages/find/widgets/hot_search_content.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/screen_loader.dart';
import 'package:flutter_wb_clone/widgets/search/search_bar.dart';
import 'package:flutter_wb_clone/widgets/weiboitem/weibo_item_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

import 'dart:math' as math;

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with TickerProviderStateMixin {
  List<String> _tabValues = ['热点', '本地', '话题', '超话'];

  TabController _tabController;
  bool isLoading = true;

  List<Findhottop> _findHotSearchList = []; // 顶部热搜列表
  List<Findkind> _findKindList = [];
  Findhotcenter _findCenter;

  List<WeiboModel> _findHotList = []; // 热点列表
  List<WeiboModel> _findLocalList = []; // 本地列表
  Findtopic _findtopic; // 话题模块
  List<WeiboModel> _superTopicList = []; // 超话列表

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: _tabValues.length, vsync: this);
    loadData();
  }

  /// 加载数据
  loadData() async {
    try {
      String id = Provider.of<UserProvider>(context, listen: false).userInfo.id;
      Response res =
          await DioManager().post(ServiceUrl.getFindHomeInfo, {'userId': id});
      if (res.data['status'] == 200) {
        print('输出的数据=====${res.data}');
        FindHomeModel mModel = FindHomeModel.fromJson(res.data['data']);
        setState(() {
          _findHotSearchList = mModel.findhottop;
          _findKindList = mModel.findkind;
          _findCenter = mModel.findhotcenter;
          _findHotList = mModel.findhot;
          _findLocalList = mModel.findlocal;
          _findtopic = mModel.findtopic;
          _superTopicList = mModel.findsupertopic;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showToast('加载失败');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showToast('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: isLoading
          ? ScreenLoader(
              width: 100,
              height: 100,
            )
          : extended.NestedScrollView(
              pinnedHeaderSliverHeightBuilder: () {
                return kToolbarHeight + MediaQuery.of(context).padding.top - 15;
              },
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: SearchBar(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            Utils.getImageByName('find_search.png'),
                            width: 22.0,
                            height: 25.0,
                          ),
                          Text(
                            '微博热搜',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HotSearchContent(_findHotSearchList),
                  SliverToBoxAdapter(
                    child: _buildDiver(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildKind(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildDiver(),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _SliverAppBarDelegate(
                      minHeight: 50,
                      maxHeight: 50,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            isScrollable: true,
                            indicatorColor: Color(0xffff3700),
                            indicator: UnderlineTabIndicator(
                                insets: EdgeInsets.only(bottom: 7),
                                borderSide: BorderSide(
                                    color: Color(0xffff3700), width: 2)),
                            labelColor: Color(0xff333333),
                            unselectedLabelColor: Color(0xff666666),
                            labelStyle: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w700),
                            unselectedLabelStyle: TextStyle(fontSize: 16.0),
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: _tabController,
                            tabs: _tabValues
                                .map((e) => Tab(
                                      text: '$e',
                                    ))
                                .toList(),
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
                children: <Widget>[
                  _buildBody(_findHotList),
                  _buildBody(_findLocalList),
                  _buildBody(_findHotList),
                  _buildBody(_superTopicList),
                ],
              ),
            ),
    );
  }

  /// 渲染内容
  _buildBody(List<WeiboModel> list) {
    return EasyRefresh(
      header: MaterialHeader(),
      onRefresh: () async {
        await loadData();
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          WeiboModel model = list[index];
          return InkWell(
            onTap: () {},
            child: WeiboItem(mModel: model),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _buildDiver() {
    return Container(
      height: 10,
      color: Color(0xfffafafa),
    );
  }

  Widget _buildKind() {
    return Container(
      child: Column(
        children: <Widget>[_buildKindContent(), _buildKindSwiper()],
      ),
    );
  }

  Widget _buildKindContent() {
    return Row(
      children: <Widget>[Expanded(child: Container())],
    );
  }

  Widget _buildKindSwiper() {
    return Container(
      height: 190,
      child: Swiper(
        outer: true,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                size: 7,
                space: 5,
                color: Color(0xfff0f0f0),
                activeColor: Color(0xffd8d8d8))),
        itemBuilder: (context, index) {
          return _bannerItem(index);
        },
        itemCount: _findCenter == null ? 0 : 5,
      ),
    );
  }

  /// 渲染banner
  _bannerItem(index) {
    List<Findhottop> _centerList = [];
    if (index == 0) {
      _centerList = _findCenter.page1;
    } else if (index == 1) {
      _centerList = _findCenter.page2;
    } else if (index == 2) {
      _centerList = _findCenter.page3;
    } else if (index == 3) {
      _centerList = _findCenter.page4;
    } else if (index == 4) {
      _centerList = _findCenter.page5;
    }

    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 2.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(_centerList[0].recommendcoverimg))),
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color(0xffFB304E)),
                          padding:
                              EdgeInsets.only(left: 4, right: 5, bottom: 2),
                          child: Center(
                            child: Text("热搜",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white)),
                          ),
                        ),
                        Text(
                          "#" + _centerList[0].hotdesc + "#",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text(
                          _centerList[0].hotdiscuss +
                              "讨论  " +
                              _centerList[0].hotread +
                              "阅读",
                          style: TextStyle(fontSize: 10, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 2.5, bottom: 2.5, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                _centerList[1].recommendcoverimg))),
                    child: Container(
                        padding: EdgeInsets.only(left: 3, right: 3, bottom: 3),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "#" + _centerList[1].hotdesc + "#",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 2.5, top: 2.5, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                _centerList[2].recommendcoverimg))),
                    child: Container(
                        padding: EdgeInsets.only(left: 3, right: 3, bottom: 3),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "#" + _centerList[2].hotdesc + "#",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ],
            ))
      ],
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
