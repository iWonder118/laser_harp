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
  double lazerThickness = 5;
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
              height: 5,
              margin: EdgeInsets.fromLTRB(10, 100, 10, 100),
              color: Colors.greenAccent[700],
            ),
            Container(
              width: lazerWidth2,
              height: 5,
              margin: EdgeInsets.fromLTRB(10, 310, 10, 100),
              color: Colors.greenAccent[700],
            ),
            Container(
              width: lazerWidth3,
              height: 5,
              margin: EdgeInsets.fromLTRB(10, 520, 10, 100),
              color: Colors.greenAccent[700],
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
                lazerWidth1 = judgeCrossLine(100);
                lazerWidth2 = judgeCrossLine(310);
                lazerWidth3 = judgeCrossLine(520);
                plyaSound(100, "sound1");
                plyaSound(310, "sound2");
                plyaSound(520, "sound3");
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

  double judgeCrossLine(double startY) {
    return (startY <= _currentPositionY &&
            _currentPositionY <= startY + lazerThickness)
        ? _currentPositionX - 10
        : MediaQuery.of(context).size.width;
  }

  void plyaSound(double startY, String fileName) async {
    if (startY <= _currentPositionY &&
        _currentPositionY <= startY + lazerThickness) {
      if (!islazer1Played) {
        _player.play('$fileName.mp3');
        islazer1Played = true;
        await Future.delayed(Duration(seconds: 1));
        islazer1Played = false;
      }
    }
  }
}
