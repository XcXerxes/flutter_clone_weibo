/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-27 15:48:20
 * @LastEditors: leo
 * @LastEditTime: 2020-07-27 20:48:10
 */
import 'package:flutter/material.dart';
import 'package:flutter_wb_clone/helpers/utils.dart';
import 'package:flutter_wb_clone/models/findHomeModel.dart';
import 'package:flutter_wb_clone/routes/find_router.dart';
import 'package:flutter_wb_clone/routes/navigator_utils.dart';

class HotSearchContent extends StatelessWidget {
  final List<Findhottop> _list;
  HotSearchContent(@required this._list);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double mHeight = 30;
    final double mWidth = size.width / 2;
    return SliverList(
      delegate: SliverChildListDelegate([
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 120,
                  child: GridView.builder(
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: mWidth / mHeight),
                    itemBuilder: (context, index) {
                      return _buildSearchItem(context, index, _list);
                    },
                    itemCount: _list.length + 1,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 1,
                    color: Color(0xffe4e4e4),
                    height: 90,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        )
      ]),
    );
  }

  _buildSearchItem(context, index, list) {
    if (index == 7) {
      return _buildMore(context);
    }
    Findhottop hottop = list[index];
    EdgeInsetsGeometry mMargin;
    if (index % 2 != 0) {
      mMargin = EdgeInsets.only(left: 0, right: 10);
    } else {
      mMargin = EdgeInsets.only(left: 10, right: 0);
    }
    return InkWell(
      onTap: () {
        String mTitle = _list[index].hotdesc;
        String mImg = _list[index].recommendcoverimg;
        String mReadCount = _list[index].hotread;

        String mHost = _list[index].hothost;
        NavigatorUtils.push(context,
            '${FindRouter.findTopicDetail}?mTitle=${Uri.encodeComponent(mTitle)}&mImg=${Uri.encodeComponent(mImg)}&mReadCount=$mReadCount&mHost=${Uri.encodeComponent(mHost)}');
      },
      child: Container(
        padding: (index % 2 == 0)
            ? EdgeInsets.only(left: 0, right: 0)
            : EdgeInsets.only(left: 10, right: 0),
        margin: mMargin,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                '${hottop.hotdesc}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 20),
              child: _buildTypeWidget('1'),
            )
          ],
        ),
      ),
    );
  }

  _buildTypeWidget(String type) {
    if (type == '1') {
      return Image.asset(
        Utils.getImageByName('find_hs_hot.jpg'),
        width: 17,
        height: 17,
      );
    }
    if (type == '2') {
      return Image.asset(
        Utils.getImageByName('find_hs_new.jpg'),
        width: 17,
        height: 17,
      );
    }
    if (type == '3') {
      return Image.asset(
        Utils.getImageByName('find_hot_rec.jpg'),
        width: 17,
        height: 17,
      );
    }
    return SizedBox.shrink();
  }

  _buildMore(context) {
    return InkWell(
      onTap: () {
        NavigatorUtils.push(context, FindRouter.findTopic);
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Text(
            '更多热搜',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15, color: Color(0xfffb7a0e)),
          ),
          Image.asset(Utils.getImageByName('find_hs_more.png'),
              width: 20, height: 20)
        ],
      ),
    );
  }
}
