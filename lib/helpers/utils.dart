/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:52:58
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 18:26:11
 */

import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/constant.dart';
import 'package:flutter_wb_clone/widgets/screen_loader.dart';

class Utils {
  static String getImageByName(String imageName) {
    return Constant.ASSETS_IMG + imageName;
  }
}

class CustomLoader {
  static CustomLoader _customLoader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader;
    }
  }

  OverlayState _overlayState;
  OverlayEntry _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(builder: (context) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: buildLoader(context),
      );
    });
  }

  showLoader(BuildContext context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState.insert(_overlayEntry);
  }

  hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print('Exception：$e');
    }
  }

  buildLoader(BuildContext context, {Color backgroundColor}) {
    if (backgroundColor == null) {
      backgroundColor = const Color(0xffa8a8a8).withOpacity(.5);
    }
    var height = 100.0;
    return ScreenLoader(
      height: height,
      width: height,
      backgroundColor: backgroundColor,
    );
  }
}
