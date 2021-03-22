import 'package:flutter/material.dart';
import 'package:flutter_app1/page/button_home_page.dart';
import 'package:flutter_app1/page/card.dart';
import 'package:flutter_app1/page/countdown_page.dart';
import 'package:flutter_app1/page/countdown_timer_page.dart';
import 'package:flutter_app1/page/text_Page.dart';

class MyTestPage extends StatefulWidget {
  MyTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyTestPageState createState() => _MyTestPageState();
}

class _MyTestPageState extends State<MyTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            textStudy(context: context),
            buttonStudy(context: context),
            cardStudy(context: context),
            buildItem(context,"countdown", CountdownPage()),
            buildItem(context,"countdown page", CountdownTimerPage()),
          ],
        ),
      ),
    );
  }
}

Widget cardStudy({BuildContext context}) {
  return Listener(
    onPointerDown: (event) =>
    {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyCardPage(title: 'card')))
    },
    child: Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        '卡片组件学习',
        style: TextStyle(fontSize: 20.0),
      ),
    ),
  );
}

Widget buttonStudy({BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: FlatButton(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Text(
        '按钮组件学习',
        style: TextStyle(fontSize: 16.0),
      ),
      color: Colors.blue,
      highlightColor: Colors.blue[700],
      colorBrightness: Brightness.dark,
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      onPressed: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new MyButtonHomePage(title: 'button')));
      },
    ),
  );
}

Widget textStudy({BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePage(title: 'text')));
    },
    child: Container(
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: Text(
        '文字组件学习',
        style: TextStyle(fontSize: 20.0),
      ),
    ),
  );
}
Widget buildItem(BuildContext context,String title, Widget page) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return page;
      }));
    },
    child: Container(
      margin: const EdgeInsets.all(5),
      color: Colors.blue,
      width: double.infinity,
      alignment: Alignment.center,
      height: 100,
      child: Text(title, style: TextStyle(fontSize: 36),),
    ),
  );
}
