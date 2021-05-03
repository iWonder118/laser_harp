import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import "dart:math";
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';

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
  double lazerThickness = 2;
  double lazer1HeightPersent = 0.2;
  double lazer2HeightPersent = 0.44;
  double lazer3HeightPersent = 0.68;
  bool islazer1Played = false;
  bool islazer2Played = false;
  bool islazer3Played = false;
  AudioCache _player = AudioCache(prefix: "music/");

  @override
  Widget build(BuildContext context) {
    double bodyWidth = MediaQuery.of(context).size.width;
    double bodyHeight = MediaQuery.of(context).size.height;
    double lazerWidth1 = bodyWidth;
    double lazerWidth2 = bodyWidth;
    double lazerWidth3 = bodyWidth;
    double lazer1Height = bodyHeight * lazer1HeightPersent;
    double lazer2Height = bodyHeight * lazer2HeightPersent;
    double lazer3Height = bodyHeight * lazer3HeightPersent;
    double lazerWidthMargin = bodyWidth * 0.15;
    Image lazerHarpImage = Image.asset('assets/images/lazerharp1.png');

    double crossLineAnimation(double startY) {
      return (startY <= _currentPositionY &&
              _currentPositionY <= startY + lazerThickness)
          ? _currentPositionX - lazerWidthMargin
          : bodyHeight;
    }

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
            Container(
              width: lazerWidth1,
              height: lazerThickness,
              margin: EdgeInsets.fromLTRB(
                  lazerWidthMargin, lazer1Height, lazerWidthMargin, 0),
              color: Colors.greenAccent[700],
            ),
            Container(
              width: lazerWidth2,
              height: lazerThickness,
              margin: EdgeInsets.fromLTRB(
                  lazerWidthMargin, lazer2Height, lazerWidthMargin, 0),
              color: Colors.greenAccent[700],
            ),
            Container(
              width: lazerWidth3,
              height: lazerThickness,
              margin: EdgeInsets.fromLTRB(
                  lazerWidthMargin, lazer3Height, lazerWidthMargin, 0),
              color: Colors.greenAccent[700],
            ),
            Center(
              child: lazerHarpImage,
            ),
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                _currentPositionX =
                    max(0, min(details.localPosition.dx, bodyWidth));
                _currentPositionY =
                    max(0, min(details.localPosition.dy, bodyWidth));
                lazerWidth1 = crossLineAnimation(lazer1Height);
                lazerWidth2 = crossLineAnimation(lazer2Height);
                lazerWidth3 = crossLineAnimation(lazer3Height);
                plyaSound(lazer1Height, "sound1");
                plyaSound(lazer2Height, "sound2");
                plyaSound(lazer3Height, "sound3");
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
