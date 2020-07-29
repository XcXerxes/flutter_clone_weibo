/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:21:23
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 22:49:02
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/pages/find/find_page.dart';
import 'package:flutter_wb_clone/pages/home/home_page.dart';
import 'package:flutter_wb_clone/pages/media/media_page.dart';
import 'package:flutter_wb_clone/pages/message/message_page.dart';
import 'package:flutter_wb_clone/pages/profile/profile_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List tabImages;
  PageController pageController;

  int _currentPage = 0;

  @override
  initState() {
    pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  Image getTabImage(String path) {
    return Image.asset(path, width: 25.0, height: 25.0);
  }

  void initData() {
    tabImages = [
      [
        getTabImage('assets/images/tabbar_home.png'),
        getTabImage('assets/images/tabbar_home_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_video.png'),
        getTabImage('assets/images/tabbar_video_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_discover.png'),
        getTabImage('assets/images/tabbar_discover_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_message_center.png'),
        getTabImage('assets/images/tabbar_message_center_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_profile.png'),
        getTabImage('assets/images/tabbar_profile_highlighted.png')
      ],
    ];
  }

  BottomNavigationBarItem _buildNavBottomBarItem(
      Image icon, Image activeIcon, String text) {
    return BottomNavigationBarItem(
        icon: icon,
        activeIcon: activeIcon,
        title: Text('$text', style: TextStyle(color: Colors.black87)));
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          MediaPage(),
          FindPage(),
          MessagePage(),
          ProfilePage()
        ],
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildNavBottomBarItem(tabImages[0][0], tabImages[0][1], '首页'),
          _buildNavBottomBarItem(tabImages[1][0], tabImages[1][1], '视频'),
          _buildNavBottomBarItem(tabImages[2][0], tabImages[2][1], '发现'),
          _buildNavBottomBarItem(tabImages[3][0], tabImages[3][1], '消息'),
          _buildNavBottomBarItem(tabImages[4][0], tabImages[4][1], '我的'),
        ],
        currentIndex: _currentPage,
        onTap: (int page) {
          pageController.jumpToPage(page);
        },
      ),
    );
  }
}
