import 'package:json_annotation/json_annotation.dart';

part 'videoModel.g.dart';

@JsonSerializable()
class VideoModel {
    VideoModel();

    num id;
    String coverimg;
    num videotime;
    num playnum;
    num userid;
    String tag;
    String recommengstr;
    num type;
    String introduce;
    num createtime;
    String username;
    String userheadurl;
    num userisvertify;
    num zannum;
    String videourl;
    num userfancount;
    String userdesc;
    
    factory VideoModel.fromJson(Map<String,dynamic> json) => _$VideoModelFromJson(json);
    Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
