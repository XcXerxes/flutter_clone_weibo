/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-28 01:03:58
 * @LastEditors: leo
 * @LastEditTime: 2020-07-28 01:27:29
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class PersonInfoTabView extends StatefulWidget {
  final String nick;
  final String decs;
  final int createtime;
  final String gender;
  PersonInfoTabView({this.nick, this.decs, this.createtime, this.gender});
  @override
  _PersonInfoTabViewState createState() => _PersonInfoTabViewState();
}

class _PersonInfoTabViewState extends State<PersonInfoTabView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: TitleText(
            text: '基本资料',
          ),
        ),
        Divider(
          height: 1,
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: ListTile.divideTiles(context: context, tiles: [
              _buildCell('昵称', widget.nick),
              _buildCell('简介', widget.decs),
              _buildCell('注册时间', '2019-5-5 22:30'),
              _buildCell('性别', widget.gender),
              _buildCell('阳光信用', '120'),
            ]).toList(),
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              color: Colors.white,
              onPressed: () {},
              child: TitleText(
                text: '查看全部微博',
                color: Colors.black87,
                fontSize: 16,
              )),
        )
      ],
    ));
  }

  _buildCell(String label, String value) {
    return ListTile(
      leading: Container(
        child: TitleText(
          text: '$label',
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
      title: Text('$value'),
    );
  }
}
