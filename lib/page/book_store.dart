import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/model/book_tab.dart';
import 'package:flutter_app1/network/api/api.dart';
import 'package:flutter_app1/page/book_list.dart';
import 'package:flutter_app1/utils/colors_util.dart';
import 'package:flutter_app1/network/api/net_util.dart';

import 'dart:convert';

class BookStore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BookStoreState();
  }
}

class BookStoreState extends State<BookStore> with TickerProviderStateMixin {
  TabController tabController;
  List<BookTab> myTabs = new List();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: myTabs.length);
    getTabList();
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  //异步网络请求获取tab的数组信息
  void getTabList() async {
    String url = Api.BOOK_TAB;
    // String url = Api.BOOK_LIST;
    NetUtils.get(url).then((data) {
      print(data.toString());

      if (data != null) {
        Map<String, dynamic> map = json.decode(data);

        print('map' + map.toString());
        if (map['errorCode'] == 0) {
          List _listdata = map['data'];

          for (int i = 0; i < _listdata.length; i++) {
            String str = _listdata[i]['name'];
            int id = _listdata[i]['id'];
            print('str:' + str + "id:$id");

            myTabs.add(new BookTab(str, new BookList(id: _listdata[i]['id'])));
          }
        }
        tabController = new TabController(vsync: this, length: myTabs.length);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFFEAE9E7),
        title: new TabBar(
          labelColor: Color(ColorsUtil.TYPEFACE_BLACK),
          unselectedLabelColor: Color(ColorsUtil.TYPEFACE_BLACK),
          indicatorWeight: 2.0,
          controller: tabController,
          tabs: myTabs.map((item) {
            return new Tab(text: item.text);
          }).toList(),
          //使用Tab类型的数组呈现Tab标签
          indicatorColor: Color(ColorsUtil.TYPEFACE_BLACK),
          isScrollable: true,
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: myTabs.map((item) {
          // return item.bookList;
          return item.bookList;
        }).toList(),
      ),
    );
  }
}
