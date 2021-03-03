import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app1/page/test_page.dart';
import 'package:flutter_app1/utils/image_util.dart';
import 'package:flutter_app1/utils/string_util.dart';

class MyInfoPage extends StatefulWidget {
  MyInfoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  String nick = '';
  File imageHeader;
  String des = '点击登录';
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ListView(
        children: [
          loginTop(),
          cardView(),
          Container(
            height: 5.0,
            color: const Color(0x30bab9b9),
          ),
          itemWant(),
          Container(
            height: 5.0,
            color: const Color(0x30bab9b9),
          ),
          itemFabulous(),
          Container(
            height: 5.0,
            color: const Color(0x30bab9b9),
          ),
          setting(context: context),
          Container(
            height: 5.0,
            color: const Color(0x30bab9b9),
          ),
        ],
      ),
    );
  }
}

Widget setting({BuildContext context}) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new MyTestPage(title: '设置'))),
    child: Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(25.0),
            child: getImage('images/icon_my.png'),
          ),
          Expanded(
              child: Text(
            '设置',
            style: TextStyle(fontSize: 16.0),
          )),
        ],
      ),
    ),
  );
}

Widget itemFabulous() {
  return Container(
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: getImage('images/icon_star.png'),
        ),
        Expanded(
            child: Text(
          '收藏的文章',
          style: TextStyle(fontSize: 16.0),
        )),
        Container(
          margin: EdgeInsets.all(25.0),
          child: Text(
            '0篇',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    ),
  );
}

Widget itemWant() {
  return Container(
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: getImage('images/icon_home.png'),
        ),
        Expanded(
            child: Text(
          '想要的文章',
          style: TextStyle(fontSize: 16.0),
        )),
        Container(
          margin: EdgeInsets.all(25.0),
          child: Text(
            '0篇',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    ),
  );
}

Widget cardView() {
  var nameString = '立即领取';
  return Container(
    margin: EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 0.0),
    child: Stack(
      children: [
        Image.asset(
          'images/img_card.png',
          height: 150.0,
          width: 400.0,
        ),
        Container(
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          '强力推荐卡',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                      Container(
                        child: Text(
                          '给力书单',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showToast('$nameString'),
                child: Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Text(
                    nameString,
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget loginTop() {
  return GestureDetector(
    onTap: () {
      //点击之后判断
    },
    child: Column(
      children: [
        //头像
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10.0),
          child: CircleAvatar(
            backgroundImage: new AssetImage('images/img_header.jpeg'),
            backgroundColor: Colors.white,
            radius: 40.0,
          ),
        ),
        //用户名
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            'nick',
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
      ],
    ),
  );
}
