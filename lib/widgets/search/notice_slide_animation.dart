/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 14:39:16
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 15:04:41
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';

class NoticeSlideAnimation extends StatefulWidget {
  final Duration duration;
  final List<String> messages;
  NoticeSlideAnimation(
      {this.messages, this.duration = const Duration(milliseconds: 4000)});
  @override
  _NoticeSlideAnimationState createState() => _NoticeSlideAnimationState();
}

class _NoticeSlideAnimationState extends State<NoticeSlideAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;

  int _nextMessage = 0;

  //透明度
  Animation<double> _opacityAni1, _opacityAni2;
  // 位移
  Animation<Offset> _positionAni1, _positionAni2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startVerticalAni();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAni2,
      child: FadeTransition(
        opacity: _opacityAni2,
        child: SlideTransition(
          position: _positionAni1,
          child: FadeTransition(
            opacity: _opacityAni1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  Utils.getImageByName('find_top_search.png'),
                  width: 12,
                  height: 15,
                ),
                Text(
                  widget.messages[_nextMessage],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Color(0xffee565656)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 纵向滚动
  _startVerticalAni() {
    if (_controller != null) {
      return;
    }
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _opacityAni1 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0, 0.1, curve: Curves.linear)));
    _opacityAni2 = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)));

    _positionAni1 = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.linear)),
    );

    _positionAni2 = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -0.3),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _nextMessage++;
          if (_nextMessage >= widget.messages.length) {
            _nextMessage = 0;
          }
          _controller.reset();
          _controller.forward();
        });
      }
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _controller = null;
    super.dispose();
  }
}
