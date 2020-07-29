/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 10:52:43
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 11:39:01
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:video_player/video_player.dart';

class WeiboVideo extends StatefulWidget {
  final String url;
  final String previewImgUrl; // 预览图片地址
  final bool showProgressText; // 是否显示进度文本
  final double aspectRatio;
  final bool isAutoPlay;
  WeiboVideo({this.previewImgUrl, this.url, this.aspectRatio, this.isAutoPlay = false, this.showProgressText = true});
  @override
  _WeiboVideoState createState() => _WeiboVideoState();
}

class _WeiboVideoState extends State<WeiboVideo> {
  VideoPlayerController _controller;
  bool _showSeekBar = true;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        if(widget.isAutoPlay) {
          _controller.play();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio == null ? _controller.value.aspectRatio : widget.aspectRatio,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          GestureDetector(
            child: VideoPlayer(_controller),
            onTap: () {
              setState(() {
                _showSeekBar = !_showSeekBar;
              });
            },
          ),
          _buildControl(),
          // VideoProgressIndicator(_controller, allowScrubbing: true)
        ],
      ),
    );
  }

  Widget _buildControl() {
    return Offstage(
      offstage: !_showSeekBar,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: 45,
              icon: Image.asset(Utils.getImageByName(_controller.value.isPlaying
                  ? 'ic_pause.png'
                  : 'ic_playing.png')),
              onPressed: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
