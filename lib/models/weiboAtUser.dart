import 'package:json_annotation/json_annotation.dart';

part 'weiboAtUser.g.dart';

@JsonSerializable()
class WeiboAtUser {
    WeiboAtUser();

    String id;
    String nick;
    String headurl;
    String decs;
    num gender;
    num followCount;
    num fanCount;
    String tagIndex;
    String namePinyin;
    
    factory WeiboAtUser.fromJson(Map<String,dynamic> json) => _$WeiboAtUserFromJson(json);
    Map<String, dynamic> toJson() => _$WeiboAtUserToJson(this);
}
