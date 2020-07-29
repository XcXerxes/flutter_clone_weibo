/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 13:18:00
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 13:42:14
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  AuthButton({this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Color(0xffFF8200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.symmetric(vertical: 10),
      textColor: Colors.white,
      disabledTextColor: Colors.white,
      disabledColor: Color(0xffFFD8AF),
      onPressed: onPressed,
      child: TitleText(
        text: '$text',
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}
