/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 20:29:44
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 22:07:20
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/findHomeModel.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:oktoast/oktoast.dart';

class FindTopicPage extends StatefulWidget {
  @override
  _FindTopicPageState createState() => _FindTopicPageState();
}

class _FindTopicPageState extends State<FindTopicPage> {
  bool isShowTitle = false;

  List<Findhottop> _hotList = [];

  /// 监听滚动事件
  _listScrollChange(offset) {
    print('offset========$offset');
    if (offset > 100) {
      setState(() {
        isShowTitle = true;
      });
    } else {
      setState(() {
        isShowTitle = false;
      });
    }
  }

  @override
  initState() {
    loadData();
    super.initState();
  }

  /// 加载数据
  loadData() async {
    try {
      Response res = await DioManager().post(ServiceUrl.getHotSearchList, null);
      print('输出======${res.data}');
      if (res.data['status'] == 200) {
        _hotList.clear();
        print('输出======${res.data}');
        res.data['data'].forEach((item) {
          _hotList.add(Findhottop.fromJson(item));
        });
        setState(() {});
        showToast('加载成功');
      }
    } catch (e) {
      showToast('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification &&
              notification.depth == 0) {
            /// 滚动监听
            _listScrollChange(notification.metrics.pixels);
          }
          return true;
        },
        child: Stack(
          children: <Widget>[
            extended.NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: isShowTitle ? Colors.black87 : Colors.white,
                        ),
                        onPressed: () {
                          NavigatorUtils.goBack(context);
                        }),
                    title: isShowTitle ? Text('微博热搜') : Text(''),
                    centerTitle: true,
                    expandedHeight: 210,
                    backgroundColor: Color(0xfff8f8f8),
                    elevation: 0,
                    floating: false,
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search,
                            color: isShowTitle ? Colors.black87 : Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_horiz,
                            color: isShowTitle ? Colors.black87 : Colors.white),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Container(
                        height: 210,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    Utils.getImageByName('hot_search_top.png')),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  )
                ];
              },
              body: _buildBody(),
            )
          ],
        ),
      ),
    );
  }

  /// render body
  _buildBody() {
    return EasyRefresh.custom(
      onRefresh: () async {
        await loadData();
      },
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 5, left: 10),
            color: Color(0xffeeeeee),
            child: TitleText(
              text: '实时热点,每分钟更新一次',
              fontSize: 12,
              color: Color(0xff333333),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, i) {
            return _buildItem(i);
          }, childCount: _hotList.length),
        )
      ],
    );
  }

  /// 渲染item
  _buildItem(i) {
    Findhottop _item = _hotList[i];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: .5, color: Colors.black12))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                TitleText(
                  text: '${i + 1}',
                  color: Colors.red,
                  fontSize: 14,
                ),
                SizedBox(width: 10),
                TitleText(
                  text: '${_item.hotdesc}',
                  fontSize: 13,
                  color: Colors.black87,
                ),
                SizedBox(width: 10),
                TitleText(
                  text: '${_item.hotread}',
                  fontSize: 10,
                  color: Colors.grey,
                )
              ],
            ),
          )),
          Container(
            child: _getIcon(_item.hottype),
          )
        ],
      ),
    );
    // return (
    //   leading: TitleText(
    //     text: '${i + 1}',
    //     color: Colors.red,
    //     fontSize: 14,
    //   ),
    //   title: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       TitleText(
    //         text: '${_item.hotdesc}',
    //         fontSize: 13,
    //         color: Colors.black87,
    //       ),
    //       SizedBox(width: 10),
    //       TitleText(
    //         text: '${_item.hotread}',
    //         fontSize: 10,
    //         color: Colors.grey,
    //       )
    //     ],
    //   ),
    // );
  }

  /// 获取icon
  _getIcon(String type) {
    String path = '';
    if (type == '1') {
      path = 'find_hs_hot.jpg';
    } else if (type == '2') {
      path = 'find_hs_new.jpg';
    } else if (type == '3') {
      path = 'find_hot_rec.jpg';
    }
    if (path.isNotEmpty) {
      return Image.asset(Utils.getImageByName(path), width: 17, height: 17);
    }
    return Container(
      height: 17,
    );
  }
}
