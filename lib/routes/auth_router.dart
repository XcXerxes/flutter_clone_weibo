/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 21:10:10
 * @LastEditors: leo
 * @LastEditTime: 2020-07-24 21:11:48
 */

import 'package:fluro/fluro.dart';
import 'package:flutter_wb_clone/pages/auth/signin_page.dart';
import 'package:flutter_wb_clone/routes/init_router.dart';

class AuthRouter implements IRouterProvider {
  static String signin = '/signin';

  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(signin,
        handler: Handler(
          handlerFunc: (context, parameters) => SigninPage(),
        ));
  }
}
