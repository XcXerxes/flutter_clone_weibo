/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 21:10:10
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 17:22:18
 */

import 'package:fluro/fluro.dart';
import 'package:flutter_wb_clone/pages/profile/profile_edit_desc_page.dart';
import 'package:flutter_wb_clone/pages/profile/profile_edit_user_page.dart';
import 'package:flutter_wb_clone/pages/profile/profile_setting_page.dart';
import 'package:flutter_wb_clone/pages/profile/profile_user_page.dart';
import 'package:flutter_wb_clone/routes/init_router.dart';

class ProfileRouter implements IRouterProvider {
  static String profileUser = '/profile/user';
  static String profileSetting = '/profile/setting';
  static String profileEditUser = '/profile/edituser';
  static String profileEditDesc = '/profile/editdesc';

  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(profileUser,
        handler: Handler(
          handlerFunc: (context, parameters) => ProfileUserPage(),
        ));
    router.define(profileSetting,
        handler: Handler(
          handlerFunc: (context, parameters) => ProfileSettingPage(),
        ));
    router.define(profileEditUser,
        handler: Handler(
          handlerFunc: (context, parameters) =>
              ProfileEditUserPage(title: parameters['title']?.first),
        ));
    router.define(profileEditDesc,
        handler: Handler(
          handlerFunc: (context, parameters) =>
              ProfileEditDescPage(title: parameters['title']?.first),
        ));
  }
}
