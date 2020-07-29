import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/widgets/title_text.dart';

class MessageTabView extends StatefulWidget {
  @override
  _MessageTabViewState createState() => _MessageTabViewState();
}

class _MessageTabViewState extends State<MessageTabView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: EasyRefresh.custom(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildTop(),
          ),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverToBoxAdapter(
            child: _buildList(),
          )
        ],
      ),
    );
  }

  _buildTop() {
    return Container(
      margin: EdgeInsets.only(top: 1),
      child: Column(
        children: ListTile.divideTiles(context: context, tiles: [
          _buildTopItem('@我的', 'message_at.webp'),
          _buildTopItem('评论', 'message_comments.png'),
          _buildTopItem('赞', 'message_good.webp')
        ]).toList(),
      ),
    );
  }

  _buildTopItem(String text, String url) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(Utils.getImageByName(url)),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: TitleText(
          text: '$text',
          fontSize: 16,
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  _buildList() {
    return Container(
      margin: EdgeInsets.only(top: 1),
      child: Column(
        children: ListTile.divideTiles(context: context, tiles: [
          _buildItem('@测试号001', subtitle: '明天几点吃完饭?', time: '19:22'),
          _buildItem('@测试号002', subtitle: '可以啊，做的太好了', time: '10:22'),
          _buildItem('@测试号001', subtitle: '明天几点吃完饭?', time: '19:22'),
        ]).toList(),
      ),
    );
  }

  _buildItem(String title, {String subtitle, String url, String time}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
            "https://c-ssl.duitang.com/uploads/item/201208/30/20120830173930_PBfJE.thumb.700_0.jpeg"),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: TitleText(
          text: '$title',
          fontSize: 16,
        ),
      ),
      subtitle: Text('$subtitle'),
      trailing: Column(
        children: <Widget>[
          TitleText(
            text: '$time',
            fontSize: 12,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
