/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-26 16:55:31
 * @LastEditors: leo
 * @LastEditTime: 2020-07-26 20:29:23
 */
import 'package:azlistview/azlistview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/screen_loader.dart';
import 'package:lpinyin/lpinyin.dart';

class WeiboPublishAtUserPage extends StatefulWidget {
  @override
  _WeiboPublishAtUserPageState createState() => _WeiboPublishAtUserPageState();
}

class _WeiboPublishAtUserPageState extends State<WeiboPublishAtUserPage> {
  List<WeiboAtUser> userList = [];
  List<WeiboAtUser> recommendList = [];

  int _suspensionHeight = 30;
  int _itemHeight = 60;
  String _suspensionTag = '';
  bool loading = true;

  @override
  initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    try {
      Response res = await DioManager().post(ServiceUrl.getWeiBoAtUser, null);
      print('输出内容===========${res.data}');
      setState(() {
        loading = false;
      });
      if (res.data['status'] == 200) {
        userList = getList(res.data['data']['normalusers']);
        print('长度为========${userList.length}');
        recommendList = getList(res.data['data']['hotusers']);
        recommendList.forEach((value) {
          value.tagIndex = '★';
        });
        _handleList(userList);
        setState(() {
          if (recommendList.length > 0) {
            _suspensionTag = recommendList[0].getSuspensionTag();
          }
        });
      }
      return res.data;
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('输出错误===========$e');
      return null;
    }
  }

  _handleList(List<WeiboAtUser> list) {
    if (list == null || list.isEmpty) return;
    for (var i = 0; i < list.length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].nick);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }

    /// 根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(userList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('联系人'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[_buildList()],
      ),
    );
  }

  List<WeiboAtUser> getList(List list) {
    List<WeiboAtUser> _list = [];
    for (var i = 0; i < list.length; i++) {
      _list.add(WeiboAtUser.fromJson(list[i]));
    }
    return _list;
  }

  _buildSusWidget(String susTag) {
    susTag = (susTag == '★' ? '推荐联系人' : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: EdgeInsets.only(left: 15),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text('$susTag',
          softWrap: false,
          style: TextStyle(fontSize: 14, color: Color(0xff999999))),
    );
  }

  /// 渲染su
  onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  /// 渲染listitem
  _buildListItem(WeiboAtUser model) {
    String susTag = model.getSuspensionTag();
    susTag = (susTag == '1' ? '热门城市' : susTag);
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            leading: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage('${model.headurl}'),
            ),
            title: Text('${model.nick}'),
            onTap: () {
              Navigator.of(context).pop(model);
            },
          ),
        )
      ],
    );
  }

  _buildList() {
    return Expanded(
        child: loading
            ? Center(
                child: ScreenLoader(
                  width: 100,
                  height: 100,
                ),
              )
            : AzListView(
                topData: userList,
                data: recommendList,
                itemBuilder: (context, model) => _buildListItem(model),
                suspensionWidget: _buildSusWidget(_suspensionTag),
                isUseRealIndex: true,
                itemHeight: _itemHeight,
                suspensionHeight: _suspensionHeight,
                onSusTagChanged: onSusTagChanged,
              ));
  }
}

class WeiboAtUser extends ISuspensionBean {
  String id;
  String nick;
  String headurl;
  String decs;
  int gender;
  int followCount;
  int fanCount;
  String tagIndex;
  String namePinyin;

  WeiboAtUser(
      {this.id,
      this.nick,
      this.headurl,
      this.decs,
      this.gender,
      this.followCount,
      this.fanCount,
      this.tagIndex,
      this.namePinyin});

  WeiboAtUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nick = json['nick'];
    headurl = json['headurl'];
    decs = json['decs'];
    gender = json['gender'];
    followCount = json['followCount'];
    fanCount = json['fanCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nick'] = this.nick;
    data['headurl'] = this.headurl;
    data['decs'] = this.decs;
    data['gender'] = this.gender;
    data['followCount'] = this.followCount;
    data['fanCount'] = this.fanCount;
    return data;
  }

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return tagIndex;
  }
}
