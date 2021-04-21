import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import "dart:math";
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
    double bodyWidth = MediaQuery.of(context).size.width;
    double bodyHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            Center(
              child: Container(
                width: bodyWidth,
                height: bodyHeight,
                color: Colors.black,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: lazerWidth1,
                  height: 5,
                  margin: EdgeInsets.fromLTRB(75, 205, 75, 0),
                  color: Colors.greenAccent[700],
                ),
                Container(
                  width: lazerWidth2,
                  height: 5,
                  margin: EdgeInsets.fromLTRB(75, 205, 75, 0),
                  color: Colors.greenAccent[700],
                ),
                Container(
                  width: lazerWidth3,
                  height: 5,
                  margin: EdgeInsets.fromLTRB(75, 205, 75, 0),
                  color: Colors.greenAccent[700],
                ),
              ],
            ),
            Center(
              child: Image.asset(
                'assets/images/lazerharp1.png',
                width: bodyWidth,
                height: bodyHeight,
              ),
            ),
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                _currentPositionX =
                    max(0, min(details.localPosition.dx, bodyWidth));
                _currentPositionY =
                    max(0, min(details.localPosition.dy, bodyWidth));
                lazerWidth1 = judgeCrossLine(bodyWidth, 205);
                lazerWidth2 = judgeCrossLine(bodyWidth, 415);
                lazerWidth3 = judgeCrossLine(bodyWidth, 625);
                plyaSound(205, "sound1");
                plyaSound(415, "sound2");
                plyaSound(625, "sound3");
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

  double judgeCrossLine(double bodyWidth, double startY) {
    return (startY <= _currentPositionY &&
            _currentPositionY <= startY + lazerThickness)
        ? _currentPositionX - 75
        : bodyWidth;
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
