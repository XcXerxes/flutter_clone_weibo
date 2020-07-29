// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..username = json['username'] as String
    ..nick = json['nick'] as String
    ..headurl = json['headurl'] as String
    ..decs = json['decs'] as String
    ..gender = json['gender'] as String
    ..followCount = json['followCount'] as String
    ..fanCount = json['fanCount'] as String
    ..ismember = json['ismember'] as num
    ..isvertify = json['isvertify'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nick': instance.nick,
      'headurl': instance.headurl,
      'decs': instance.decs,
      'gender': instance.gender,
      'followCount': instance.followCount,
      'fanCount': instance.fanCount,
      'ismember': instance.ismember,
      'isvertify': instance.isvertify
    };
