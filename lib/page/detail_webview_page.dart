import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/utils/string_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final data;

  ///是否允許收藏
  final supportCollect;

  WebViewPage(this.data, {this.supportCollect = false});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoad = true;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // _controller.future.then((value) {
    //   setState(() {
    //     value.reload();
    //     print(value.currentUrl());
    //   });
    //
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isCollect = widget.data['collect'] ?? false;
    return WillPopScope(
      onWillPop: () {
        return _goBack(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data['title']),
          actions: <Widget>[
            Offstage(
                offstage: !widget.supportCollect,
                child: Container(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite,
                            color: isCollect ? Colors.red : Colors.white),
                        onPressed: () => showToast('点击收藏'),
                      ),
                      IconButton(
                        icon: Icon(Icons.autorenew, color: Colors.white),
                        onPressed: () => showToast('刷新页面'),
                      ),
                    ],
                  ),
                )),
          ],

          //加载样式1
          //appbar下边摆放一个进度条
          // bottom: PreferredSize(
          //     //提供一个希望的 大小
          //     preferredSize: const Size.fromHeight(1.0),
          //     //进度条
          //     child: const LinearProgressIndicator()),
          //
          // ///透明度
          // bottomOpacity: isLoad ? 1.0 : 0.0,
        ),
        //加载样式1
        // body: Container(
        //   child: WebView(
        //     initialUrl: widget.data['url'], //需要打开的url
        //     onWebViewCreated: (WebViewController controller) {
        //       //页面加载的时候可以获取到controller可以用来reload等操作
        //       _controller.complete(controller);
        //     },
        //     navigationDelegate: (NavigationRequest navigationRequest){
        //       print("加载的是: ${navigationRequest.url}");
        //       setState(() {
        //         isLoad = true;// 开始访问页面，更新状态
        //       });
        //       return  NavigationDecision.navigate;
        //     },
        //     onPageFinished: (String url){
        //       setState(() {
        //         isLoad = false;// 页面加载完成，更新状态
        //       });
        //     },
        //   ),
        // ),

        //加载样式2
        body: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              //允许js调用
              // javascriptChannels: _loadJavascriptChannel(context),
              initialUrl: widget.data['url'],
              //需要打开的url
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
                if (navigationRequest.url.startsWith("jianshu://")) {
                  print("即将打开 ${navigationRequest.url}");
                  //对简书做了拦截处理，，可以进一步直接跳转到简书App
                  _launchURL(navigationRequest.url);
                  return NavigationDecision.prevent;
                }
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
      ),
    );
  }

  //跳转第三方
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //webview 回退
  Future _goBack(BuildContext context) async {
    if (_controller != null && await _controller.future.then((value) => value.canGoBack())) {
      _controller.future.then((value) {
        if(value!=null){
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

  Set _loadJavascriptChannel(BuildContext context) {
    final Set channels = Set();
    JavascriptChannel toastChannel = JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
    channels.add(toastChannel);
    return channels;
  }
// _collect() async {
//   var result;
//   bool isLogin =  AppManager.isLogin();
//   if (isLogin) {
//     if (widget.data['collect']) {
//       result = await Api.unCollectArticle(widget.data['id']);
//     } else {
//       result = await Api.collectArticle(widget.data['id']);
//     }
//   } else {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (_) => LoginPage()));
//   }
//   if (result['errorCode'] == 0) {
//     setState(() {
//       widget.data['collect'] = !widget.data['collect'];
//       AppManager.eventBus.fire(CollectEvent(widget.data['id'],widget.data['collect']));
//     });
//   }
// }
}
