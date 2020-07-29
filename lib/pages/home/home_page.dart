/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:22:29
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 14:30:14
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/pages/home/weibo_follow_tabview.dart';
import 'package:flutter_wb_clone/pages/home/weibo_hot_tabview.dart';
import 'package:flutter_wb_clone/routes/home_router.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
              backgroundColor: Color(0xfffafafa),
              elevation: 0,
              leading: SizedBox.shrink(),
              title: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(text: HomeTabModel('关注', 0).title),
                  Tab(text: HomeTabModel('热门', 1).title),
                ],
                labelColor: Color(0xff333333),
                indicatorColor: Color(0xffff3700),
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                unselectedLabelColor: Color(0xff666666),
              )),
          body: TabBarView(
              controller: _tabController,
              children: [WeiboFollowTabview(), WeiboHotTabview()]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              NavigatorUtils.push(context, HomeRouter.homePublish,
                  transitionType: TransitionType.cupertinoFullScreenDialog);
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}

class HomeTabModel {
  final String title;
  final int index;
  HomeTabModel(this.title, this.index);
}
