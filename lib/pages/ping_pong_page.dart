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

class _PingPongState extends State<PingPong> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Positioned(
              child: Ball(),
              top: 0,
            ),
            Positioned(
              bottom: 0,
              child: Bat(200, 25),
            )
          ],
        );
      },
    );
  }
}
