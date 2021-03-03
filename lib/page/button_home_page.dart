import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/utils/string_util.dart';

class MyButtonHomePage extends StatefulWidget {
  MyButtonHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyButtonHomePageState createState() => _MyButtonHomePageState();
}

class _MyButtonHomePageState extends State<MyButtonHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            Column(
              // 默认竖直方向排列的容器widget, 类似于Android的LinearLayout。
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // RaisedButton 默认带有阴影和灰色背景。按下后阴影会变大。
                RaisedButton(
                  child: Text("不可点击状态"), // button中的文字显示
                  onPressed: (){}, // 点击事件,如果赋值为null, 则控件状态为不可用,显示灰色不可点击
                ),
                RaisedButton(
                  child: Text("正常状态"), // button中的文字显示
                  onPressed: () {
                    // 具体逻辑
                  }, // 点击事件,正常状态
                ),
                RaisedButton(
                  child: Text("打印我是可点击的RaisedButton"), // button中的文字显示
                  onPressed: () {
                    // 具体逻辑
                    showToast("我是可点击的RaisedButton");
                  }, // 点击事件,正常状态
                ),
                RaisedButton(
                  child: Text("打印我是可点击的RaisedButton"), // button中的文字显示
                  onPressed: () => showToast("我是可点击的RaisedButton"), // 点击事件,正常状态
                ),

                /// FlatButton 扁平化的按钮, 默认背景透明且不带阴影, 按下出现背景但没有阴影。
                /// 点击事件和结构和RaisedButton一致, 只是样式有些不同而已。
                FlatButton(
                  child: Text("FlatButton"),
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () => showToast("我是可点击的FlatButton"),
                ),

                /// OutlineButton 默认有一个边框, 不带阴影且背景透明。按下后边框颜色会变亮、同时出现背景和阴影。
                /// 点击事件和结构和RaisedButton一致, 只是样式有些不同而已。
                OutlineButton(
                  textColor: Colors.purpleAccent,
                  borderSide: BorderSide(
                    // 默认情况下的边框样式
                      color: Colors.amber),
                  highlightedBorderColor: Colors.red, // 按下时边框的颜色
                  child: Text("OutlineButton"),
                  onPressed: () => showToast("我是可点击的OutlineButton"),
                ),

                RaisedButton.icon(
                  onPressed: () => showToast("带图标的RaiseButton"),
                  icon: Icon(Icons.adb),
                  label: Text("Adb"),
                ),
                FlatButton.icon(
                  textColor: Colors.lightGreenAccent,
                  onPressed: () => showToast("带图标的FlatButton"),
                  icon: Icon(Icons.access_alarms),
                  label: Text("Alarm"),
                ),
                OutlineButton.icon(
                  textColor: Colors.blue,
                  onPressed: () => showToast("带图标的OutlineButton"),
                  icon: Icon(Icons.print),
                  label: Text("Printer"),
                ),
                //
                // /// 圆角按钮, 圆角是通过shape属性定义的, RaisedButton、FlatButton、OutlineButton都有该属性。
                // /// 我们以RaiseButton为例定义。
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder( //
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("圆角按钮"),
                  onPressed: () => showToast("圆角按钮"),
                ),

                /// ButtonBar 定义一组控件, 如果一行的宽度足够, 则按照子控件都在一行排列
                /// 如果子控件太多一行控件不够排列, 则按照竖直方向排列。
              ],
            )
          ],
        ),
      ),
    );

  }
}
