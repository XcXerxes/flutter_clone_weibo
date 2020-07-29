/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 14:22:57
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 19:27:13
 */

import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_wb_clone/pages/home/weibo_publish_atuser_page.dart';
import 'package:flutter_wb_clone/pages/home/weibo_publish_page.dart';
import 'package:flutter_wb_clone/routes/init_router.dart';

class HomeRouter implements IRouterProvider {
  static String homePublish = '/home/publish';
  static String homePublishAtUser = '/home/publish/atuser';

  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(homePublish,
        handler: Handler(
          handlerFunc: (context, parameters) => WeiboPublishPage(),
        ));
    router.define(homePublishAtUser,
        handler: Handler(
          handlerFunc: (context, parameters) => WeiboPublishAtUserPage(),
        ));
  }
}
