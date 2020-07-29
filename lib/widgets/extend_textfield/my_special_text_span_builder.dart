/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 14:57:03
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 15:06:13
 */

import 'dart:ui';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_wb_clone/widgets/extend_textfield/at_text.dart';
import 'package:flutter_wb_clone/widgets/extend_textfield/emoji_text.dart';
import 'package:flutter_wb_clone/widgets/extend_textfield/topic_text.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  final bool showAtBackground;
  MySpecialTextSpanBuilder({this.showAtBackground = false});

  @override
  TextSpan build(String data, {TextStyle textStyle, onTap}) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText createSpecialText(String flag,
      {TextStyle textStyle, onTap, int index}) {
    // TODO: implement createSpecialText
    if (flag == null || flag == '') {
      return null;
    }
    if (isStart(flag, AtText.flag)) {
      return AtText(textStyle, onTap,
          start: index - (AtText.flag.length - 1),
          showAtBackground: showAtBackground);
    } else if (isStart(flag, TopicText.flag)) {
      return TopicText(textStyle, onTap,
          start: index - (TopicText.flag.length - 1),
          showAtBackground: showAtBackground);
    } else if (isStart(flag, EmojiText.flag)) {
      return EmojiText(textStyle, onTap,
          start: index - (EmojiText.flag.length - 1),
          showAtBackground: showAtBackground);
    }
    return null;
  }
}
