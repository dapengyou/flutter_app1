import 'package:flutter/material.dart';
import 'package:flutter_app1/page/button_home_page.dart';
import 'package:flutter_app1/page/card.dart';
import 'package:flutter_app1/page/book_store.dart';
import 'package:flutter_app1/page/myInfo_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_app1/page/webview_js_page.dart';



var pages = [
  new BookStore(),
  new WebViewJsPage(),
  // new MyCardPage(title: 'card'),
  // new MyButtonHomePage(title: 'button')
  new MyInfoPage(title: '我的'),
];

var tabItems = [
  TabItem(icon: Icons.home, title: 'Home'),
  TabItem(icon: Icons.message, title: 'Message'),
  TabItem(icon: Icons.people, title: 'Profile'),
];