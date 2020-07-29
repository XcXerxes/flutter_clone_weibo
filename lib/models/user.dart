import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    String id;
    String username;
    String nick;
    String headurl;
    String decs;
    String gender;
    String followCount;
    String fanCount;
    num ismember ;
    num isvertify ;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
