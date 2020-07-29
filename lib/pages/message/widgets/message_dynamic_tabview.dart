
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class MessageDynamicTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(Utils.getImageByName('msg_no_dynamic.webp'), width: 120, height: 120, fit: BoxFit.fill),
          SizedBox(height: 5),
          TitleText(
            text: '你暂时还没有动态',
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
