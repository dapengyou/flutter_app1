import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/utils/string_util.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewJsPage extends StatefulWidget {
  @override
  _WebViewJsPageState createState() => _WebViewJsPageState();
}

class _WebViewJsPageState extends State<WebViewJsPage> {
  bool isLoad = true;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _goBack(context);
      },
      child: Scaffold(
        body: Stack(
          children: [
            WebView(
              //允许js调用
              initialUrl: 'http://wzw.test.oupeng.com/signin',//加载任务页
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[
                _alertJavascriptChannel(context),
                // _userInfoJavascriptChannel(context)
              ].toSet(),
              // initialUrl: _loadHtmlFromAsset().toString(),
              onWebResourceError:(WebResourceError error){//获取资源失败
                _loadHtmlFromAsset('assets/error_page.html')
                    .toString();
              },
              //需要打开的url
              onWebViewCreated: (WebViewController controller) {
                //页面加载的时候可以获取到controller可以用来reload等操作
                _controller.complete(controller);
              },
              navigationDelegate: (NavigationRequest navigationRequest) {
                //拦截请求
                print("加载的是: ${navigationRequest.url}");
                if (mounted) {
                  setState(() {
                    isLoad = true; // 开始访问页面，更新状态
                  });
                }

                if (navigationRequest.url.startsWith("baiduboxlite://")) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              onPageFinished: (String url) {
                if (mounted) {
                  setState(() {
                    isLoad = false; // 页面加载完成，更新状态
                  });
                }
                _controller.future.then(
                    (value) => value.evaluateJavascript("OupengJsInterface"));
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _controller.future.then((value) => value.evaluateJavascript('flutterCallJS("hidden")'));
          },
        ),
      ),
    );
  }

  //加载本地的html
  Future _loadHtmlFromAsset(String text) async {
    // String html = 'assets/test_js.html';
    final String path = await rootBundle.loadString(text);
    //webviewController 在webview初始化时可获得
    await _controller.future.then((value) => value.loadUrl(Uri.dataFromString(
            path,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'))
        .toString()));
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'OupengJsInterface',
        onMessageReceived: (JavascriptMessage message) {
          showToast(message.message);
        });
  }

  JavascriptChannel _userInfoJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'OupengJsInterface.getUserInfo',
        onMessageReceived: (JavascriptMessage message) {
          showToast(message.message);
          print(message.message != null);
          if (message.message != null) {
            print('刷新页面');
            _controller.future.then((value) => value.reload());
          }
        });
  }


  //webview 回退
  Future _goBack(BuildContext context) async {
    if (_controller != null &&
        await _controller.future.then((value) => value.canGoBack())) {
      _controller.future.then((value) {
        if (mounted && value != null) {
          setState(() {
            value.goBack();
          });
        }
      });
      return false;
    }
    Navigator.of(context).pop(true);

    return true;
  }


}
