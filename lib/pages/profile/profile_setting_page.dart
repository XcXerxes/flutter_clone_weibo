/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-28 11:24:10
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 19:05:16
 */
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/models/index.dart';
import 'package:flutter_wb_clone/pages/profile/widgets/my_action_sheet.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';
import 'package:flutter_wb_clone/routes/profile_router.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ProfileSettingPage extends StatefulWidget {
  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  User get user => Provider.of<UserProvider>(context, listen: false).userInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  /// 退出登录
  _logout() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text('退出微博?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
              FlatButton(
                  onPressed: () {
                    print('e');
                  },
                  child: Text('确认')),
            ],
          );
        });
  }

  /// 拍照
  _buildCamera() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      print('file=========$pickedFile');
      if (pickedFile != null) {}
    } catch (e) {
      showToast('没有安装相机');
    }
  }

  /// 从相册选择
  _buildPhotos() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      print('file=========$pickedFile');
    } catch (e) {}
  }

  /// 查看大图
  /// 取消
  /// 修改头像
  _chooseImage() async {
    try {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 233 + MediaQuery.of(context).padding.bottom,
              color: Color(0xfffafafa),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildActionsheetItem('立即拍照', onTap: _buildCamera),
                  Divider(
                    height: 1,
                  ),
                  _buildActionsheetItem('从相册选择', onTap: _buildPhotos),
                  Divider(
                    height: 1,
                  ),
                  _buildActionsheetItem('查看大图', onTap: () {}),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 55 + MediaQuery.of(context).padding.bottom,
                      child: TitleText(
                        text: '取消',
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
      // _scaffoldKey.currentState.showBottomSheet((context) {
      //   return MyActionSheet(
      //       child: Container(
      //     width: double.infinity,
      //     height: 210,
      //     color: Color(0xfffafafa).withOpacity(.4),
      //     child: Container(
      //       color: Color(0xfffafafa),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: <Widget>[
      //           Container(
      //             width: double.infinity,
      //             child: FlatButton(
      //                 padding:
      //                     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //                 onPressed: () {},
      //                 color: Colors.white,
      //                 child: TitleText(
      //                   text: '立即拍照',
      //                 )),
      //           ),
      //           Container(
      //             width: double.infinity,
      //             child: FlatButton(
      //                 padding:
      //                     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //                 onPressed: () {},
      //                 color: Colors.white,
      //                 child: TitleText(
      //                   text: '从相册选择',
      //                 )),
      //           ),
      //           Container(
      //             width: double.infinity,
      //             child: FlatButton(
      //                 padding:
      //                     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //                 onPressed: () {},
      //                 color: Colors.white,
      //                 child: TitleText(
      //                   text: '查看大图',
      //                 )),
      //           ),
      //           SizedBox(height: 20),
      //           Container(
      //             width: double.infinity,
      //             child: FlatButton(
      //                 padding:
      //                     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //                 onPressed: () {},
      //                 color: Colors.white,
      //                 child: TitleText(
      //                   text: '取消',
      //                 )),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ));
      //   // return Container(
      //   //   width: double.infinity,
      //   //   color: Color(0xfffafafa),
      //   //   height: 200,
      //   //   child: Column(
      //   //     children: <Widget>[
      //   //       Container(
      //   //         width: double.infinity,
      //   //         child: FlatButton(
      //   //             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //   //             onPressed: () {},
      //   //             color: Colors.white,
      //   //             child: TitleText(
      //   //               text: '立即拍照',
      //   //             )),
      //   //       ),
      //   //       Container(
      //   //         width: double.infinity,
      //   //         child: FlatButton(
      //   //             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //   //             onPressed: () {},
      //   //             color: Colors.white,
      //   //             child: TitleText(
      //   //               text: '从相册选择',
      //   //             )),
      //   //       ),
      //   //       Container(
      //   //         width: double.infinity,
      //   //         child: FlatButton(
      //   //             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //   //             onPressed: () {},
      //   //             color: Colors.white,
      //   //             child: TitleText(
      //   //               text: '查看大图',
      //   //             )),
      //   //       )
      //   //     ],
      //   //   ),
      //   // );
      // }, backgroundColor: Colors.black.withOpacity(.6));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('设置'),
      ),
      body: EasyRefresh(
        onRefresh: () async {},
        header: BallPulseHeader(),
        child: ListView(
          padding: EdgeInsets.only(top: 5),
          children: <Widget>[
            _buildList(),
            SizedBox(height: 25),
            _buildOtherList(),
            SizedBox(height: 25),
            _buildLogout()
          ],
        ),
      ),
    );
  }

  /// 渲染acitonsheetItem
  _buildActionsheetItem(String title, {GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 55,
        child: TitleText(
          text: '$title',
        ),
      ),
    );
  }

  /// 渲染列表
  _buildList() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: ListTile.divideTiles(context: context, tiles: [
          _buildItem('头像管理',
              trailing: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.headurl),
              ),
              onTap: _chooseImage),
          _buildItem('用户昵称',
              trailing: TitleText(
                text: '${user.nick}',
                fontSize: 16,
              ), onTap: () {
            NavigatorUtils.push(context,
                '${ProfileRouter.profileEditUser}?title=${Uri.encodeComponent(user.nick)}');
          }),
          _buildItem('个性签名', onTap: () {
            NavigatorUtils.push(context,
                '${ProfileRouter.profileEditDesc}?title=${Uri.encodeComponent(user.decs)}');
          }),
          _buildItem(
            '生日',
          ),
          _buildItem(
            '所在区域',
          ),
        ]).toList(),
      ),
    );
  }

  _buildOtherList() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: ListTile.divideTiles(context: context, tiles: [
          _buildItem(
            '意见反馈',
          ),
          _buildItem(
            '关于微博',
          ),
          _buildItem(
            '清理缓存',
          )
        ]).toList(),
      ),
    );
  }

  /// 渲染item
  _buildItem(String title, {Widget trailing, GestureTapCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: TitleText(
        text: '$title',
        fontSize: 16,
        color: Colors.black87,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          trailing != null ? trailing : SizedBox.shrink(),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }

  _buildLogout() {
    return Container(
      child: FlatButton(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          onPressed: _logout,
          child: TitleText(
            text: '退出微博',
            color: Colors.red,
          )),
    );
  }
}
