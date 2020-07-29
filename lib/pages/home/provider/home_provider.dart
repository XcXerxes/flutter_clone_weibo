/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 00:08:20
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 00:40:14
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';

class HomeProvider extends ChangeNotifier {
  List<WeiboModel> feedList = [];

  /// 获取微博内容列表
  Future getFeedList(dynamic params) async {
    try {
      Response res = await DioManager().post(ServiceUrl.getWeiBo, params);

      if (res.data['status'] == 200) {
        print('输出=========${res.data['data']['list']}');
        setDatatoModel(res.data['data']['list']);
      }
      notifyListeners();
      return res.data;
    } catch (e) {
      print('error=====$e');
      notifyListeners();
      return null;
    }
  }

  /// json to Model
  setDatatoModel(List list) {
    for (var i = 0; i < list.length; i++) {
      feedList.add(WeiboModel.fromJson(list[i]));
    }
  }
}
