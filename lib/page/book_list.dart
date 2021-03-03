import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app1/network/api/api.dart';
import 'package:flutter_app1/network/api/net_util.dart';
import 'package:flutter_app1/widget/article_item.dart';

class BookList extends StatefulWidget {
  final int id; //类型id

  BookList({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _NewListState(id);
  }
}

class _NewListState extends State<BookList> with AutomaticKeepAliveClientMixin {
  //滑动控制器
  ScrollController _controller = new ScrollController();

  //控制正在加载的显示
  bool _isHide = true;

  //请求到的文章数据
  List articles = [];

  //总文章数有多少
  var totalCount = 0;

  //分页加载，当前页码
  var curPage = 0;

  int id;

  _NewListState(int id) {
    this.id = id;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ///获得 SrollController 监听控件可以滚动的最大范围
      var maxScroll = _controller.position.maxScrollExtent;

      ///获得当前位置的像素值
      var pixels = _controller.position.pixels;

      ///当前滑动位置到达底部，同时还有更多数据
      if (maxScroll == pixels && curPage < totalCount) {
        ///加载更多
        _getArticlelist();
      }
    });
    _pullToRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getArticlelist([bool update = true]) async {
    /// 请求成功是map，失败是null
    String url = await Api.getArticleList(curPage, id);
    print('NEWS_LIST:' + url);

    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['errorCode'] == 0) {
          // print('data:'+data);
          var data = map['data'];
          var datas = data['datas'];
          //文章总数
          totalCount = data["pageCount"];

          if (curPage == 0) {
            articles.clear();
          }
          curPage++;
          articles.addAll(datas);

          ///更新ui,加 mounted 判断的原因是避免 异步消息未返回
          if (mounted && update) {
            setState(() {});
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///正在加载
        Offstage(
          offstage: !_isHide, //是否隐藏
          child: new Center(child: CircularProgressIndicator()),
        ),

        ///内容
        Offstage(
          offstage: _isHide,

          ///SwipeRefresh 下拉刷新组件
          child: new RefreshIndicator(
              child: ListView.builder(
                //条目数 +1代表了banner的条目
                itemCount: articles.length,
                //adapter条目item 视图生成方法
                itemBuilder: (context, i) => _buildItem(i),

                controller: _controller,
              ),
              onRefresh: _pullToRefresh),
        ),
      ],
    );
  }

  Widget _buildItem(int i) {
    return new ArticleItem(articles[i]);
  }

  //下拉刷新
  Future<void> _pullToRefresh() async {
    curPage = 0;

    ///组合两个异步任务，创建一个都完成后的新的Future
    Iterable<Future> futures = [_getArticlelist()];
    await Future.wait(futures);
    _isHide = false;

    if (mounted) {
      setState(() {});
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
