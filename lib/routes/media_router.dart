import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/routes/init_router.dart';
import 'package:flutter_wb_clone/pages/media/media_detail_page.dart';

class MediaRouter implements IRouterProvider {
  static String mediaDetail = '/media/detail';
  @override
  initRouter(Router router) {
    router.define(mediaDetail, handler: Handler(
      handlerFunc: (context, params) {
        VideoModel video = VideoModel.fromJson(jsonDecode(params['video'][0]));
        return MediaDetailPage(video);
      })
    );
  }
}
