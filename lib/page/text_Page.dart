import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Text('data'),
                new TextButton(
                  onPressed: _incrementCounter,
                  child: Text('textbutton'),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amberAccent),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 45,
                          color: Colors.purpleAccent))),
                ),
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new TextButton(
                  onPressed: () {},
                  child: Text('textbutton'),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.purpleAccent),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                        fontStyle: FontStyle.italic,
                        decorationColor:Colors.white,
                        fontSize: 45,
                      ))),
                )
              ],
            ),
            new  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new  FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  splashColor: Colors.grey,
                  child: Text("Submit"),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Container(child: Icon(Icons.add)),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}