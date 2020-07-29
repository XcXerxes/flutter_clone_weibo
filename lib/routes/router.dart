/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 20:43:19
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 00:34:26
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/pages/index/index_page.dart';
import 'package:flutter_wb_clone/pages/splash_page.dart';
import 'package:flutter_wb_clone/routes/auth_router.dart';
import 'package:flutter_wb_clone/routes/find_router.dart';
import 'package:flutter_wb_clone/routes/home_router.dart';
import 'package:flutter_wb_clone/routes/init_router.dart';
import 'package:flutter_wb_clone/routes/media_router.dart';
import 'package:flutter_wb_clone/routes/profile_router.dart';

class Routes {
  static String splash = '/splash';
  static String index = '/index';

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    router.define(splash,
        handler: Handler(handlerFunc: (context, parameters) => SplashPage()));

    router.define(index,
        handler: Handler(handlerFunc: (context, parameters) => IndexPage()));

    _listRouter.clear();

    /// 各自路由各自模块管理 统一初始化
    _listRouter.add(AuthRouter());
    _listRouter.add(HomeRouter());
    _listRouter.add(FindRouter());
    _listRouter.add(ProfileRouter());
    _listRouter.add(MediaRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
