import 'package:flutter/material.dart';
import 'package:merchant/widgets/ball.dart';
import 'package:merchant/widgets/bat.dart';

class PingPongPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ping pong'),
        ),
        body: SafeArea(
          child: PingPong(),
        ));
  }
}

class PingPong extends StatefulWidget {
  @override
  _PingPongState createState() {
    return _PingPongState();
  }
}

class _PingPongState extends State<PingPong>
    with SingleTickerProviderStateMixin {
  double width;
  double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width / 2;
        batHeight = height / 2;
        return Stack(
          children: <Widget>[
            Positioned(
              child: Ball(),
              top: 0,
            ),
            Positioned(
              bottom: 0,
              child: Bat(batWidth, batHeight),
            )
          ],
        );
      },
    );
  }
}
