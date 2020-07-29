// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weiboModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiboModel _$WeiboModelFromJson(Map<String, dynamic> json) {
  return WeiboModel()
    ..weiboId = json['weiboId'] as String
    ..categoryId = json['categoryId'] as String
    ..content = json['content'] as String
    ..zfContent = json['zfContent'] as String
    ..zfNick = json['zfNick'] as String
    ..zfUserId = json['zfUserId'] as String
    ..zfWeiBoId = json['zfWeiBoId'] as String
    ..zfVedioUrl = json['zfVedioUrl'] as String
    ..vediourl = json['vediourl'] as String
    ..tail = json['tail'] as String
    ..containZf = json['containZf'] as bool
    ..createtime = json['createtime'] as num
    ..zanStatus = json['zanStatus'] as num
    ..zhuanfaNum = json['zhuanfaNum'] as num
    ..likeNum = json['likeNum'] as num
    ..commentNum = json['commentNum'] as num
    ..userInfo = json['userInfo'] == null
        ? null
        : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>)
    ..picurl = (json['picurl'] as List)?.map((e) => e as String)?.toList()
    ..zfPicurl = (json['zfPicurl'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$WeiboModelToJson(WeiboModel instance) =>
    <String, dynamic>{
      'weiboId': instance.weiboId,
      'categoryId': instance.categoryId,
      'content': instance.content,
      'zfContent': instance.zfContent,
      'zfNick': instance.zfNick,
      'zfUserId': instance.zfUserId,
      'zfWeiBoId': instance.zfWeiBoId,
      'zfVedioUrl': instance.zfVedioUrl,
      'vediourl': instance.vediourl,
      'tail': instance.tail,
      'containZf': instance.containZf,
      'createtime': instance.createtime,
      'zanStatus': instance.zanStatus,
      'zhuanfaNum': instance.zhuanfaNum,
      'likeNum': instance.likeNum,
      'commentNum': instance.commentNum,
      'userInfo': instance.userInfo,
      'picurl': instance.picurl,
      'zfPicurl': instance.zfPicurl
    };
