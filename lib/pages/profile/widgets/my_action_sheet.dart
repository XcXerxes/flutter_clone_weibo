/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-28 12:17:17
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 15:33:46
 */
import 'package:flutter/material.dart';

class MyActionSheet extends StatelessWidget {
  final Widget child;
  MyActionSheet({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(.4),
                child: child,
              ),
            ),
          ],
        ));
  }
}
