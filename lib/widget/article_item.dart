import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/page/detail_webview_page.dart';

class ArticleItem extends StatelessWidget {
  final itemData;

  const ArticleItem(this.itemData);
  @override
  Widget build(BuildContext context) {
    ///时间与作者
    Row author = new Row( //水平线性布局
      children: <Widget>[
        //expanded 最后摆我，相当于linearlayout的weight权重
        new Expanded(
            child: Text.rich(TextSpan(children: [
              TextSpan(text: "分享者: "),
              TextSpan(
                  text: itemData['shareUser'],
                  style: new TextStyle(color: Theme.of(context).primaryColor))
            ]))),
        new Text(itemData['niceDate'])//时间
      ],
    );

    ///标题
    Text title = new Text(
      itemData['title'],
      style: new TextStyle(fontSize: 16.0, color: Colors.black),
      textAlign: TextAlign.left,
    );

    ///章节名
    Text chapterName = new Text(itemData['chapterName'],
        style: new TextStyle(color: Theme.of(context).primaryColor));

    Column column = new Column( //垂直线性布局
      crossAxisAlignment: CrossAxisAlignment.start, //子控件左对齐
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: author,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        ),
      ],
    );

    return new Card(
      ///阴影效果
      elevation: 4.0,
      // child: column,
      //添加点击跳转webview 页面
      child: InkWell(
        child: column,
        onTap: ()  async{
          await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            itemData['url'] = itemData['link'];
            return WebViewPage(
              itemData,
              supportCollect: true,
            );
          }));
        },
      ),
    );
  }
}
