import 'package:flutter/material.dart';
import "dart:math";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: new TopPage(title: "Flutterサンプル"));
  }
}

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => new _TopPageState();
}

class _TopPageState extends State<TopPage> {
  double _currentPositionX = 200;
  double _currentPositionY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${_currentPositionX.round()}",
                      style: TextStyle(fontSize: 60.0)),
                  Icon(Icons.close),
                  Text("${_currentPositionY.round()}",
                      style: TextStyle(fontSize: 60.0)),
                ],
              ),
            ),
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                _currentPositionX = max(
                    0,
                    min(details.localPosition.dx,
                        MediaQuery.of(context).size.width));
                _currentPositionY = max(
                    0,
                    min(details.localPosition.dy,
                        MediaQuery.of(context).size.height));

                setState(() {});
              },
              child: Container(
                  width: _currentPositionX,
                  height: 10,
                  color: Colors.greenAccent[400]),
            ),
          ],
        ));
  }
}
