/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 19:45:45
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 20:47:26
 */
import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_wb_clone/pages/find/find_topic_page.dart';
import 'package:flutter_wb_clone/pages/find/topic_detail_page.dart';
import 'package:flutter_wb_clone/routes/init_router.dart';

class FindRouter implements IRouterProvider {
  static String findTopicDetail = '/find/topic/detail';
  static String findTopic = '/find/topic';
  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(findTopicDetail, handler: Handler(
      handlerFunc: (context, params) {
        String mTitle = params['mTitle']?.first;
        String mImg = params['mImg']?.first;
        String mReadCount = params['mReadCount']?.first;
        String mDiscussCount = params['mDiscussCount']?.first;
        String mHost = params['mHost']?.first;
        return TopicDetailPage(mTitle, mImg, mReadCount, mDiscussCount, mHost);
      },
    ));
    router.define(findTopic,
        handler: Handler(
          handlerFunc: (context, parameters) => FindTopicPage(),
        ));
  }
}
