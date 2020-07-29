// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weiboAtUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiboAtUser _$WeiboAtUserFromJson(Map<String, dynamic> json) {
  return WeiboAtUser()
    ..id = json['id'] as String
    ..nick = json['nick'] as String
    ..headurl = json['headurl'] as String
    ..decs = json['decs'] as String
    ..gender = json['gender'] as num
    ..followCount = json['followCount'] as num
    ..fanCount = json['fanCount'] as num
    ..tagIndex = json['tagIndex'] as String
    ..namePinyin = json['namePinyin'] as String;
}

Map<String, dynamic> _$WeiboAtUserToJson(WeiboAtUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'headurl': instance.headurl,
      'decs': instance.decs,
      'gender': instance.gender,
      'followCount': instance.followCount,
      'fanCount': instance.fanCount,
      'tagIndex': instance.tagIndex,
      'namePinyin': instance.namePinyin
    };
