/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 17:32:19
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 21:05:22
 */
import 'package:flutter_wb_clone/helpers/constant.dart';

class ServiceUrl {
  /// api 地址
  static const API_CODE_SUCCESS = 200;

  static String login = Constant.baseUrl + 'manage/hrluser/login.do'; // 登录
  static String getWeiBo =
      Constant.baseUrl + 'manage/hrlweibo/list.do'; // 获取首页微博列表
  static String getWeiBoAtUser = Constant.baseUrl +
      'manage/hrlweibo/getWeiBoAtUserList.do'; //获取推荐人列表(发布微博选择@用户)
  static String publishWeiBo = Constant.baseUrl + 'manage/hrlweibo/publish.do';
  static String getVideoRecommendList =
      Constant.baseUrl + 'manage/hrlvedio/recommendlist.do'; //视频-推荐列表
  static String getVideoHotList =
      Constant.baseUrl + 'manage/hrlvedio/hotlist.do'; //视频-热门列表
  static String getVideoSmallList =
      Constant.baseUrl + 'manage/hrlvedio/smallVideolist.do'; //视频-小视频列表

  static String getFindHomeInfo = Constant.baseUrl + 'hrlfind/find.do'; //发现首页信息

  static String getHotSearchList =
      Constant.baseUrl + 'hrlfind/getHotSearchList.do'; //热搜列表

  static String getVideoDetailRecommendList =Constant.baseUrl + 'manage/hrlvedio/videodetailrecommedlist.do'; //视频详情-推荐列表

  static String getWeiBoDetailComment =Constant.baseUrl + 'hrlcomment/gainCommentsList.do'; //微博详情评论(分页获取评论)

  static String getWeiBoCommentReplyList =Constant.baseUrl + 'hrlcomment/gainCommentsReplyList.do'; //获取微博评论回复列表
}
