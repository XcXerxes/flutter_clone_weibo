/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 20:02:56
 * @LastEditors: leo
 * @LastEditTime: 2020-07-24 20:05:39
 */
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences _preferences;

  /// 初始化全局信息，会在App启动时执行
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }
}
