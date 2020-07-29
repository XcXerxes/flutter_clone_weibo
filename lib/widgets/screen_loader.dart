/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 17:50:51
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 18:12:18
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';

class ScreenLoader extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;

  ScreenLoader(
      {this.backgroundColor = const Color(0xfff8f8f8),
      this.height = 30,
      this.width = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
              Image.asset(Utils.getImageByName('welcome_android_logo.png'),
                  width: 40, height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
