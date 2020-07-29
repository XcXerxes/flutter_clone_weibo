/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 21:21:11
 * @LastEditors: leo
 * @LastEditTime: 2020-07-24 21:24:38
 */
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  TitleText(
      {this.text,
      this.color = Colors.black87,
      this.fontSize = 18,
      this.fontWeight = FontWeight.normal});
  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style:
          TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
    );
  }
}
