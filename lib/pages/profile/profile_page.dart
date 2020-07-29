/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:26:24
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 11:29:24
 */
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';
import 'package:flutter_wb_clone/routes/profile_router.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: EasyRefresh(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _buildUserInfo(),
          SizedBox(height: 10),
          _buildGridLayout(context),
          SizedBox(height: 20),
          _buildCellLayout()
        ],
      )),
    );
  }

  // 头部
  _buildAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Image.asset(Utils.getImageByName('icon_mine_add_friends.png'),
              width: 25, height: 25),
          onPressed: () {}),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Image.asset(Utils.getImageByName('icon_mine_qrcode_2.png'),
                width: 25, height: 25),
            onPressed: () {}),
        IconButton(
            icon: Image.asset(Utils.getImageByName('icon_mine_setting.png'),
                width: 25, height: 25),
            onPressed: () {
              NavigatorUtils.push(context, ProfileRouter.profileSetting);
            })
      ],
      title: Text('我的'),
    );
  }

  /// 渲染用户信息
  _buildUserInfo() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[_buildUser(), _buildUserAction()],
      ),
    );
  }

  /// 渲染头部
  _buildUser() {
    User user = Provider.of<UserProvider>(context, listen: false).userInfo;
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            onTap: () {
              NavigatorUtils.push(context, ProfileRouter.profileUser);
            },
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user.headurl),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: user.nick,
                  color: Colors.orange,
                ),
                TitleText(
                  text: '${user.decs}',
                  color: Colors.grey,
                  fontSize: 12,
                )
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Divider()
      ],
    );
  }

  ///渲染action
  _buildUserAction() {
    User user = Provider.of<UserProvider>(context, listen: false).userInfo;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          _buildUserActionItem('微博', '15'),
          _buildUserActionItem('关注', user.followCount),
          _buildUserActionItem('粉丝', user.fanCount),
        ],
      ),
    );
  }

  _buildUserActionItem(String label, String value) {
    return Expanded(
      child: Column(
        children: <Widget>[
          TitleText(
            text: '$value',
            fontSize: 16,
          ),
          SizedBox(height: 5),
          TitleText(
            text: '$label',
            fontSize: 12,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  /// 渲染grid
  _buildGridLayout(context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Wrap(
        runSpacing: 20,
        children: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width) / 4,
              child: _buildGridItem('icon_mine_pic.png', '我的相册'),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width) / 4,
              child: _buildGridItem('icon_mine_story.png', '我的故事'),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width) / 4,
              child: _buildGridItem('icon_mine_zan.png', '我的赞'),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width) / 4,
              child: _buildGridItem('icon_mine_fans.png', '我的粉丝'),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width) / 4,
              child: _buildGridItem('icon_mine_wallet.png', '微博钱包'),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width) / 4,
              child: _buildGridItem('icon_mine_gchoose.png', '微博优选'),
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width) / 4,
              child: _buildGridItem('icon_mine_fannews.png', '粉丝头条'),
            ),
          ),
          InkWell(
            child: Container(
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width) / 4,
                child: _buildGridItem('icon_mine_customservice.png', '客服中心')),
          ),
        ],
      ),
    );
  }

  /// 渲染griditem
  _buildGridItem(String url, String label) {
    return Column(
      children: <Widget>[
        Image.asset(Utils.getImageByName(url), width: 30, height: 30),
        SizedBox(height: 10),
        TitleText(
          text: '$label',
          fontSize: 12,
          color: Colors.black87,
        )
      ],
    );
  }

  /// 渲染cell list
  _buildCellLayout() {
    return Container(
      color: Colors.white,
      child: Column(
        children: ListTile.divideTiles(context: context, tiles: [
          _buildCell('icon_mine_freenet.png', '免流量', onTap: () {}),
          _buildCell('icon_mine_sport.png', '微博运动'),
          _buildCell('icon_mine_draft.png', '草稿箱'),
        ]).toList(),
      ),
    );
    // return Container(
    //   child: Column(
    //     children: <Widget>[
    //       _buildCell('icon_mine_freenet.png', '免流量'),
    //     ],
    //   ),
    // );
  }

  ListTile _buildCell(String url, String label, {GestureTapCallback onTap}) {
    return ListTile(
      leading: Image.asset(Utils.getImageByName(url), width: 25, height: 25),
      title: Text('$label'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }
}
