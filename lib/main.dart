import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import "dart:math";
// インポートするライブラリ
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: new TopPage(title: "レーザーハープDEMO"));
  }
}

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => new _TopPageState();
}

class _TopPageState extends State<TopPage> {
  GlobalKey globalKey = GlobalKey();
  double _currentPositionX = 0;
  double _currentPositionY = 0;
  double lazerWidth1 = 1000;
  double lazerWidth2 = 1000;
  double lazerWidth3 = 1000;
  bool islazer1Played = false;
  bool islazer2Played = false;
  bool islazer3Played = false;
  AudioCache _player = AudioCache();

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
            Container(
              width: lazerWidth1,
              height: 10,
              margin: EdgeInsets.fromLTRB(10, 100, 10, 100),
              color: Colors.greenAccent[400],
            ),
            Container(
              width: lazerWidth2,
              height: 10,
              margin: EdgeInsets.fromLTRB(10, 310, 10, 100),
              color: Colors.greenAccent[400],
            ),
            Container(
              width: lazerWidth3,
              height: 10,
              margin: EdgeInsets.fromLTRB(10, 520, 10, 100),
              color: Colors.greenAccent[400],
            ),
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details) async {
                _currentPositionX = max(
                    0,
                    min(details.localPosition.dx,
                        MediaQuery.of(context).size.width));
                _currentPositionY = max(
                    0,
                    min(details.localPosition.dy,
                        MediaQuery.of(context).size.height));
                lazerWidth1 =
                    (100 <= _currentPositionY && _currentPositionY <= 110)
                        ? _currentPositionX - 10
                        : MediaQuery.of(context).size.width;
                lazerWidth2 =
                    (310 <= _currentPositionY && _currentPositionY <= 320)
                        ? _currentPositionX - 10
                        : MediaQuery.of(context).size.width;
                lazerWidth3 =
                    (520 <= _currentPositionY && _currentPositionY <= 530)
                        ? _currentPositionX - 10
                        : MediaQuery.of(context).size.width;
                if (100 <= _currentPositionY && _currentPositionY <= 110) {
                  if (!islazer1Played) {
                    _player.play('sound1.mp3');
                    islazer1Played = true;
                    await Future.delayed(Duration(seconds: 1));
                    islazer1Played = false;
                  }
                }
                if (310 <= _currentPositionY && _currentPositionY <= 320) {
                  if (!islazer2Played) {
                    _player.play('sound2.mp3');
                    islazer2Played = true;
                    await Future.delayed(Duration(seconds: 1));
                    islazer2Played = false;
                  }
                }
                if (520 <= _currentPositionY && _currentPositionY <= 530) {
                  if (!islazer3Played) {
                    _player.play('sound3.mp3');
                    islazer3Played = true;
                    await Future.delayed(Duration(seconds: 1));
                    islazer3Played = false;
                  }
                }
                setState(() {});
              },
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent),
            ),
          ],
        ));
  }
}
