/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:25:53
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 19:42:49
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/pages/message/widgets/message_dynamic_tabview.dart';
import 'package:flutter_wb_clone/pages/message/widgets/message_tabview.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  List<String> _tabs = ['动态', '消息'];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Color(0xffff3700),
          indicator: UnderlineTabIndicator(
              insets: EdgeInsets.only(bottom: 7),
              borderSide: BorderSide(color: Color(0xffff3700), width: 2)),
          isScrollable: true,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: _tabs[0],
            ),
            Tab(
              text: _tabs[1],
            )
          ],
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: null)
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[MessageDynamicTabView(), MessageTabView()],
    );
  }
}
