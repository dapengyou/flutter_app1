import 'package:flutter/material.dart';
import 'package:flutter_app1/page/button_home_page.dart';
import 'package:flutter_app1/page/card.dart';
import 'package:flutter_app1/page/text_Page.dart';
import 'package:flutter_app1/main_page_setting.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(vsync: this, length: 3);
    controller.addListener(() {
      setState(() {
        selectedIndex = controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: new IndexedStack(
            children: pages,
            index: selectedIndex,
          ),
          bottomNavigationBar: ConvexAppBar(
            items: tabItems,
            initialActiveIndex: 0, //optional, default as 0
            onTap: (int index) {
              print('click index=$index');
              setState(() {
                controller.index = index;
                selectedIndex = index;
              });
            },
          )),
    );
  }
}

//************************** 没好使 ***************************
// 返回键监听
class WillPopScopeTestRoute extends StatefulWidget {
  @override
  WillPopScopeTestRouteState createState() {
    return new WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text("1秒内连续按两次返回键退出"),
        ));
  }
}
