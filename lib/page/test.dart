import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isLoad = true; //判断加载情况

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('webview'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'http://www.baidu.com',
            onWebViewCreated: (WebViewController controller) {
              //页面加载的时候可以获取到controller可以用来reload等操作
              _controller.complete(controller);
            },
            navigationDelegate: (NavigationRequest navigationRequest) {
              //拦截请求
              print("加载的是: ${navigationRequest.url}");
              setState(() {
                isLoad = true; // 开始访问页面，更新状态
              });
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              setState(() {
                isLoad = false; // 页面加载完成，更新状态
              });
            },
          ),
          isLoad
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  //加载本地的html
  Future _loadHtmlFromAsset() async {
    String html = 'assets/test_js.html';
    final String path = await rootBundle.loadString(html);
    //webviewController 在webview初始化时可获得
    await _controller.future.then((value) => value.loadUrl(Uri.dataFromString(
            path,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'))
        .toString()));
  }
}
