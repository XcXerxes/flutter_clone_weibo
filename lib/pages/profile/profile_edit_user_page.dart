/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-28 16:07:19
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 17:20:13
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class ProfileEditUserPage extends StatefulWidget {
  final String title;
  ProfileEditUserPage({@required this.title});
  @override
  _ProfileEditUserPageState createState() => _ProfileEditUserPageState();
}

class _ProfileEditUserPageState extends State<ProfileEditUserPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _controller.text = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改昵称'),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            _buildTextField(
              hintText: '清输入您的昵称',
            ),
            _buildVerifyText(),
            _buildButton()
          ],
        ),
      ),
    );
  }

  /// formtext
  _buildTextField({int maxLength = 20, int maxLines = 1, String hintText}) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      controller: _controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: '$hintText',
          contentPadding: EdgeInsets.symmetric(horizontal: 16)),
    );
  }

  // verifyText
  _buildVerifyText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: TitleText(
        text: '4-20个字符,支持中英文、数字',
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  /// button
  _buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Color(0xffFF8200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: TitleText(
          text: '修改',
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
