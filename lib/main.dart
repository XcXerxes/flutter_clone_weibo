/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:08:44
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 14:36:02
 */
import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wb_clone/pages/home/provider/home_provider.dart';
import 'package:flutter_wb_clone/pages/splash_page.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/routes/application.dart';
import 'package:flutter_wb_clone/routes/router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());

  /// 设置安卓下方的 虚拟键样式 状态栏样式
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffffffff), // 背景颜色
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Color(0xffffffff), // 分割线颜色

        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  MyApp() {
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: OKToast(
        child: MaterialApp(
          title: 'Xerxes 微博',
          theme: ThemeData(
              primaryColor: Colors.white,
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange))),
              appBarTheme: AppBarTheme(elevation: 0, color: Color(0xfffafafa))),
          home: SplashPage(),
        ),
        position: ToastPosition.center,
        backgroundColor: Colors.black.withOpacity(0.5),
        duration: Duration(milliseconds: 1500),
        textPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      ),
    );
  }
}
