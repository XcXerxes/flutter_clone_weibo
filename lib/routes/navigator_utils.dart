/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 18:48:59
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 20:41:40
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/routes/application.dart';

class NavigatorUtils {
  static push(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      TransitionType transitionType = TransitionType.native}) {
    unfocus();
    Application.router.navigateTo(context, path,
        replace: replace, clearStack: clearStack, transition: transitionType);
  }

  static void pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false,
      bool clearStack = false,
      TransitionType transitionType = TransitionType.native}) {
    unfocus();
    Application.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: transitionType)
        .then((Object result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  static void unfocus() {
    /// 使用下面的方式，会触发不必要的build
    /// FocusScope.of(context).unfocus();
    /// https://github.com/flutter/flutter/issues/47128#issuecomment-627551073

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
