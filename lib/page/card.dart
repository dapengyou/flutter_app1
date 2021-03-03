import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/utils/string_util.dart';
import 'package:flutter_app1/page/login_page.dart';

class MyCardPage extends StatefulWidget {
  MyCardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCardPage createState() => _MyCardPage();
}

class _MyCardPage extends State<MyCardPage> {
  @override
  Widget build(BuildContext context) {
    var card = new Container(
      width: 400.0,
      height: 400.0,
      child: new Card(
        elevation: 15.0, //设置阴影
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
        child: new Column(
          children: [
            new ListTile(
              title: new Text('标题'),
              subtitle: new Text('子标题'),
              leading: new Icon(Icons.menu),
            ),
            new Divider(),
            new ListTile(
              title: new Text('内容一',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            new ListTile(
              title: new Text('内容二'),
              leading: new Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
            new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () => showToast('点击了iconbutton')),
            new Divider(
              color: Colors.black,
            ),
            IntrinsicHeight(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Text("Left_FlatButton"),
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () => showToast('点击了Left_FlatButton'),
                  ),
                  new VerticalDivider(
                    width: 1,
                    color: Colors.black,
                  ),
                  FlatButton(
                    child: Text("Right_FlatButton"),
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () => showToast('点击了Right_FlatButton'),
                  ),
                ],
              ),
            ),
            Listener(
              child: new DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange[700]]),
                    borderRadius: BorderRadius.circular(3.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0)
                    ]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onPointerDown: (event)=> Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginPage())),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: card,
      ),
    );
  }
}

class _AboutDialog extends StatefulWidget {
  final bool visible;

  _AboutDialog({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
