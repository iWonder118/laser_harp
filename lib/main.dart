import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: new MyHomePage(title: "Flutterサンプル"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incremetCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decremetCounter() {
    setState(() {
      _counter--;
      if (_counter <= 0) _counter = 0;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You have pushed the button this many times:"),
            Text(
              "$_counter",
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.down,
        mainAxisSize:  MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incremetCounter,
            tooltip: "Increment",
            child: Icon(Icons.add),
            backgroundColor: Colors.red[500]
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
          FloatingActionButton(
            onPressed: _decremetCounter,
            tooltip: "Decrement",
            child: Icon(Icons.remove),
            backgroundColor: Colors.blue[500],
          ),
        ],
      ) 
    );
  }
}
