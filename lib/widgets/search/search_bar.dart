/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 14:15:57
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 15:03:13
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/widgets/search/notice_slide_animation.dart';

class SearchBar extends StatelessWidget {
  List<String> messages = [
    '大家正在搜:  hrl本地微博上线啦!',
    '大家正在搜:  hrl话题微博上线啦!',
    '大家正在搜:  hrl超话微博上线啦!',
    '大家正在搜:  hrl热点微博上线啦!',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
            color: Color(0xffe4e2e8), borderRadius: BorderRadius.circular(5)),
        child: Container(
          child: NoticeSlideAnimation(
            messages: messages,
          ),
        ),
      ),
    );
  }
}
