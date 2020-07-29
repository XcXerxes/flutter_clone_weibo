/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-24 18:24:01
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 22:15:56
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/pages/auth/widgets/auth_button.dart';
import 'package:flutter_wb_clone/provider/user_provider.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';
import 'package:flutter_wb_clone/routes/router.dart';
import 'package:flutter_wb_clone/services/api.dart';
import 'package:flutter_wb_clone/services/request.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey _formKey = GlobalKey<FormState>();

  TextEditingController _emaliEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  CustomLoader _customLoader = CustomLoader();

  String email = '';
  String password = '';

  /// 登录
  _login() async {
    if (verifyForm()) {
      _customLoader.showLoader(context);
      Response res = await DioManager().post(ServiceUrl.login, {
        'username': _emaliEditingController.text,
        'password': _passwordEditingController.text
      });
      _customLoader.hideLoader();
      print('输出内容为：${res.data}');
      await Provider.of<UserProvider>(context, listen: false)
          .saveUserInfo(res.data['data']);
      NavigatorUtils.push(context, Routes.index);
    }
  }

  /// 验证form
  verifyForm() {
    if (_emaliEditingController.text.isEmpty) {
      showToast('请输入手机号或邮箱');
      return false;
    }
    if (_passwordEditingController.text.isEmpty) {
      showToast('请输入密码');
      return false;
    }
    return true;
  }

  /// 验证form
  get isDisable {
    return _emaliEditingController.text.isEmpty ||
        _passwordEditingController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  _buildBody() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            SizedBox(height: 30),
            _buildTextField(email,
                controller: _emaliEditingController, hintText: '手机号或者邮箱'),
            SizedBox(height: 15),
            _buildTextField(password,
                controller: _passwordEditingController,
                hintText: '密码',
                isPassword: true),
            SizedBox(height: 40),
            _buildLoginButton(),
            SizedBox(height: 4),
            _buildOther(),
          ],
        ),
      ),
    );
  }

  /// 登录按钮
  _buildLoginButton() {
    return Container(
      width: double.infinity,
      child: AuthButton(
        text: '登录',
        onPressed: isDisable ? null : _login,
      ),
    );
  }

  /// 渲染标题
  _buildTitle() {
    return TitleText(text: '请输入账号密码', fontSize: 26);
  }

  /// 渲染其他的
  _buildOther() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: TitleText(
            text: '注册',
            color: Colors.blue,
            fontSize: 16,
          ),
          onTap: () {},
        ),
        InkWell(
          child: TitleText(
            text: '忘记密码',
            color: Colors.blue,
            fontSize: 16,
          ),
          onTap: () {},
        )
      ],
    );
  }

  /// 渲染表单
  _buildTextField(String text,
      {TextEditingController controller,
      bool isPassword = false,
      String hintText}) {
    return TextField(
        controller: controller,
        obscureText: isPassword,
        enableSuggestions: true,
        onChanged: (String val) {
          setState(() {
            text = val;
          });
        },
        decoration: InputDecoration(
            hintText: '$hintText',
            suffixIcon: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.cancel, color: Colors.grey),
                iconSize: 18,
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    setState(() {
                      text = '';
                    });
                  }
                })));
  }
}
