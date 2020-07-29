// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..id = json['id'] as num
    ..nick = json['nick'] as String
    ..headurl = json['headurl'] as String
    ..decs = json['decs'] as String
    ..ismember = json['ismember'] as num
    ..isvertify = json['isvertify'] as num;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'headurl': instance.headurl,
      'decs': instance.decs,
      'ismember': instance.ismember,
      'isvertify': instance.isvertify
    };
