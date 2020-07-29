import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/pages/home/weibo_publish_atuser_page.dart';
import 'package:flutter_wb_clone/pages/home/widgets/commit_bottom_tools.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/routes/home_router.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/extend_textfield/my_special_text_span_builder.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class WeiboPublishPage extends StatefulWidget {
  @override
  _WeiboPublishPageState createState() => _WeiboPublishPageState();
}

class _WeiboPublishPageState extends State<WeiboPublishPage> {
  FocusNode focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  MySpecialTextSpanBuilder _mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder();

  final picker = ImagePicker();

  String weiBoSubmitText = '';

  CustomLoader loader = CustomLoader();

  /// 图片列表
  List<File> fileList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          _buildTweettosay(),
          CommitBottomTools(
            chooseImgTap: _addImage,
            mentionTap: _mentionTap,
            topicTap: _topicTap,
            emotionTap: _emotionTap,
          )
        ],
      ),
    );
  }

  /// 发送微博
  _submit() async {
    print('eee');
    if (_textEditingController.text.isEmpty) {
      showToast('内容不能为空');
    } else {
      try {
        loader.showLoader(context);
        Response res = await DioManager().post(ServiceUrl.publishWeiBo, {
          'userId':
              Provider.of<UserProvider>(context, listen: false).userInfo.id,
          'content': _textEditingController.text,
          'files': []
        });
        loader.hideLoader();
        showToast('提交成功');
        setState(() {
          _textEditingController.clear();
        });
        NavigatorUtils.goBack(context);
      } catch (e) {
        loader.hideLoader();
        showToast('$e');
      }
    }
  }

  /// @ 的人物
  _mentionTap() {
    NavigatorUtils.pushResult(context, HomeRouter.homePublishAtUser, (result) {
      WeiboAtUser atUser = result as WeiboAtUser;
      if (atUser != null) {
        weiBoSubmitText = '$weiBoSubmitText [@${atUser.nick}:${atUser.id}]';
        _textEditingController.text =
            '${_textEditingController.text} [@${atUser.nick}:${atUser.id}] ';
      }
    });
  }

  /// 新鲜事物
  _topicTap() {}

  /// 表情包
  _emotionTap() {}

  /// 渲染输入内容
  Widget _buildTweettosay() {
    return Expanded(
      child: ListView(
        children: <Widget>[_buildTextField(), _buildGrid()],
      ),
    );
  }

  /// 渲染输入框
  Widget _buildTextField() {
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
      child: ExtendedTextField(
        autofocus: true,
        controller: _textEditingController,
        specialTextSpanBuilder: _mySpecialTextSpanBuilder,
        maxLines: 5,
        focusNode: focusNode,
        textInputAction: TextInputAction.done,
        style: TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: '分享新鲜事',
            hintStyle: TextStyle(color: Color(0xff919191), fontSize: 15)),
      ),
    );
  }

  /// 新增图片
  _addImage() async {
    if (fileList.length >= 9) {
      showToast('最多上传9张图片.');
      return;
    }
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      fileList.add(File(pickedFile.path));
    });
  }

  /// 渲染图片 grid
  _buildGrid() {
    int mGridCount;
    print('-----------------${fileList.length}');
    if (fileList.length == 0) {
      mGridCount = 0;
    } else if (fileList.length > 0 && fileList.length < 9) {
      mGridCount = fileList.length + 1;
    } else {
      mGridCount = fileList.length;
    }
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 3,
      children: List.generate(mGridCount, (index) {
        /// 生成单个 item
        var content;
        if (index == fileList.length) {
          /// 添加图片
          var addCell = Center(
            child: Image.asset(
              Utils.getImageByName('mine_feedback_add_image.png'),
              width: double.infinity,
              height: double.infinity,
            ),
          );
          content = InkWell(
            onTap: _addImage,
            child: addCell,
          );
        } else {
          content = Stack(
            children: <Widget>[
              Center(
                child: Image.file(
                  fileList[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    Utils.getImageByName('mine_feedback_ic_del.png'),
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            ],
          );
        }
        return Container(
          margin: EdgeInsets.all(10.0),
          width: 80,
          height: 80,
          color: Color(0xffffffff),
          child: content,
        );
      }),
    );
  }

  /// 渲染appbar
  Widget _buildAppBar() {
    return AppBar(
      leading: InkWell(
        child: Center(
          child: Text('取消'),
        ),
        onTap: () {
          NavigatorUtils.goBack(context);
        },
      ),
      centerTitle: true,
      title: Column(
        children: <Widget>[
          Text('发微博'),
          TitleText(
            text: '播电影',
            color: Colors.grey,
            fontSize: 12,
          )
        ],
      ),
      actions: <Widget>[
        InkWell(
            onTap: _submit,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Color(0xffff8200),
                    borderRadius: BorderRadius.circular(10)),
                child: TitleText(
                  text: '发送',
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ))
      ],
    );
  }
}
