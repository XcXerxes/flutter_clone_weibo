/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-28 16:07:19
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 17:25:08
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class ProfileEditDescPage extends StatefulWidget {
  final String title;
  ProfileEditDescPage({@required this.title});
  @override
  _ProfileEditDescPageState createState() => _ProfileEditDescPageState();
}

class _ProfileEditDescPageState extends State<ProfileEditDescPage> {
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
        title: Text('编辑简介'),
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
            SizedBox(height: 2),
            _buildTextField(),
            _buildButton()
          ],
        ),
      ),
    );
  }

  /// formtext
  _buildTextField() {
    return TextFormField(
      maxLength: 50,
      maxLines: 4,
      controller: _controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: '请输入简介',
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
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
          text: '提交',
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
