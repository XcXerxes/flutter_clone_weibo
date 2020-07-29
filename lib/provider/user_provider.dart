/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 20:28:10
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 22:16:30
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/local_storage.dart';
import 'package:flutter_wb_clone/models/index.dart';

class UserProvider extends ChangeNotifier {
  String _token;
  User userInfo = User();
  bool get isLogin => _token != null;

  /// 初始化用户信息
  Future initUser() async {
    var _user = await LocalStorage.getString('userInfo');
    if (_user != null) {
      userInfo = User.fromJson(jsonDecode(_user));
      // await getUserInfo();
    }
    notifyListeners();
    return userInfo.id;
  }

  /// 保存用户信息
  saveUserInfo(dynamic data) async {
    if (data != null) {
      userInfo = User.fromJson(data);
      await LocalStorage.setString('userInfo', jsonEncode(userInfo));
      notifyListeners();
    }
  }

  /// 获取用户信息
  Future<User> getUserInfo(User data) async {
    var _user = await LocalStorage.getString('userInfo');
    if (_user != null) {
      userInfo = User.fromJson(jsonDecode(_user));
      // await getUserInfo();
    } else {
      userInfo = User();
    }
    notifyListeners();
    return userInfo;
  }
}
