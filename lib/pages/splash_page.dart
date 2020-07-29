/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:27:42
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 22:01:12
 */
import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/routes/application.dart';
import 'package:flutter_wb_clone/routes/auth_router.dart';
import 'package:flutter_wb_clone/routes/router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(milliseconds: 3000), () {
      initUser();
    });
    super.initState();
  }

  initUser() {
    Provider.of<UserProvider>(context, listen: false).initUser().then((token) {
      print('token===========$token');
      if (token != null) {
        Application.router.navigateTo(context, Routes.index,
            transition: TransitionType.fadeIn);
      } else {
        Application.router.navigateTo(context, AuthRouter.signin,
            transition: TransitionType.fadeIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[_buildHeader(), _buildLogo()],
    );
  }

  Widget _buildHeader() {
    return Flexible(
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 100),
          child: Image.asset(
            Utils.getImageByName('welcome_android_slogan.png'),
            width: 200,
            height: 100,
          )),
    );
  }

  Widget _buildLogo() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        alignment: Alignment.bottomCenter,
        child: Image.asset(Utils.getImageByName('welcome_android_logo.png'),
            width: 100, height: 100),
      ),
    );
  }
}
