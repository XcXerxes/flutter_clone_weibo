import 'package:json_annotation/json_annotation.dart';
import "userInfo.dart";
part 'weiboModel.g.dart';

@JsonSerializable()
class WeiboModel {
    WeiboModel();

    String weiboId;
    String categoryId;
    String content;
    String zfContent;
    String zfNick;
    String zfUserId;
    String zfWeiBoId;
    String zfVedioUrl;
    String vediourl;
    String tail;
    bool containZf;
    num createtime;
    num zanStatus;
    num zhuanfaNum;
    num likeNum;
    num commentNum;
    UserInfo userInfo;
    List<String> picurl;
    List<String> zfPicurl;
    
    factory WeiboModel.fromJson(Map<String,dynamic> json) => _$WeiboModelFromJson(json);
    Map<String, dynamic> toJson() => _$WeiboModelToJson(this);
}
