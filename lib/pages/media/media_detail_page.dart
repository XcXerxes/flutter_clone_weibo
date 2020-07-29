import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/constant.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/pages/media/widgets/media_detail_comment_tabview.dart';
import 'package:flutter_wb_clone/pages/media/widgets/media_detail_intro_tabview.dart';
import 'package:flutter_wb_clone/widgets/video/weibo_video.dart';
import 'package:video_player/video_player.dart';

class MediaDetailPage extends StatefulWidget {
  final VideoModel videoModel;
  MediaDetailPage(@required this.videoModel);
  @override
  _MediaDetailPageState createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends State<MediaDetailPage> with TickerProviderStateMixin {

  VideoPlayerController _videoPlayerController;
  List<String> _tabs = ['简介', '评论'];
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.network('${Constant.baseUrl}file/weibo3.mp4');
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 0),
        child: Column(
          children: <Widget>[
            _buildMedia(),
            _buildTabs(),
            Divider(height: 1,),
            _buildBody()
          ],
        ),
      ),
    );
  }

  _buildTabs() {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _controller,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Color(0xffFF3700),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0xffff3700), width: 2),
          insets: EdgeInsets.only(bottom: 7)
        ),
        tabs: <Widget>[Tab(text: _tabs[0]), Tab(text: _tabs[1])],
        isScrollable: true,
      ),
    );
  }

  _buildMedia() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Chewie(
        controller: ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: 16/9,
            autoPlay: true,
            looping: true
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: TabBarView(
        controller: _controller,
        children: <Widget>[
          MediaDetailIntroTabview(widget.videoModel),
          MediaDetailCommentTabview(),
        ],
      ),
    );
  }
}

