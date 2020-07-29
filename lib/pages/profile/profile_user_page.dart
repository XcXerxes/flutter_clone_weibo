import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/pages/profile/widgets/person_info_tabview.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ProfileUserPage extends StatefulWidget {
  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage>
    with TickerProviderStateMixin {
  bool isShowTitle = false;

  User user;

  TabController _tabController;

  List<String> _tabs = ['主页', '微博', '相册'];

  _listScrollChange(offset) {
    if (offset > 100) {
      setState(() {
        isShowTitle = true;
      });
    } else {
      setState(() {
        isShowTitle = false;
      });
    }
    print('offset=====$offset');
  }

  @override
  void initState() {
    // TODO: implement initState
    user = Provider.of<UserProvider>(context, listen: false).userInfo;
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification &&
              notification.depth == 0) {
            /// 滚动监听
            _listScrollChange(notification.metrics.pixels);
          }
          return true;
        },
        child: extended.NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_buildAppBar(innerBoxIsScrolled), _buildTabs()];
          },
          pinnedHeaderSliverHeightBuilder: () {
            return kToolbarHeight + MediaQuery.of(context).padding.top;
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              PersonInfoTabView(
                  nick: user.nick, decs: user.decs, gender: user.gender),
              PersonInfoTabView(
                  nick: user.nick, decs: user.decs, gender: user.gender),
              PersonInfoTabView(
                  nick: user.nick, decs: user.decs, gender: user.gender),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar(innerBoxIsScrolled) {
    return SliverAppBar(
      title: isShowTitle ? Text('${user.nick}') : Text(''),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isShowTitle ? Colors.black87 : Colors.white,
          ),
          onPressed: () {
            NavigatorUtils.goBack(context);
          }),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
              color: isShowTitle ? Colors.black87 : Colors.white,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: isShowTitle ? Colors.black87 : Colors.white,
            ),
            onPressed: () {})
      ],
      floating: false,
      pinned: true,
      primary: true,
      forceElevated: innerBoxIsScrolled,
      expandedHeight: 210,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Container(
            width: double.infinity,
            height: 210,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        Utils.getImageByName('ic_personinfo_bg4.png')),
                    fit: BoxFit.cover)),
            child: _buildUserInfo(),
          )),
    );
  }

  _buildUserInfo() {
    return Container(
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  /// 渲染tab
  _buildTabs() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50,
        maxHeight: 50,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Color(0xffff3700),
                indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.only(bottom: 7),
                    borderSide: BorderSide(color: Color(0xffff3700), width: 2)),
                labelColor: Color(0xff333333),
                unselectedLabelColor: Color(0xff666666),
                labelStyle:
                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
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
