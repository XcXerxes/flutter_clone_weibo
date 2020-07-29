import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class CommentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 35,
            height: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: FadeInImage(fit: BoxFit.cover,
                placeholder: AssetImage(Utils.getImageByName('img_default2.png')), image: NetworkImage(''),),
            ),
          ),
          Expanded(child: _buildContent())
        ],
      )
    );
  }

  _buildContent() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: <Widget>[
          _buildUser(),
          _buildDes()
        ],
      ),
    );
  }
  _buildUser() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TitleText(
          text: '魔法兔的荣耀',
          color: Color(0xffF86119),
          fontSize: 14,
        ),
        SizedBox(width: 4),
        Image.asset(
          Utils.getImageByName('home_memeber.webp'),
          width: 15.0,
          height: 13.0,
        )
      ],
    );
  }

  _buildDes() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Text(
        '2943949934341',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14
        ),
      ),
    );
  }

}
