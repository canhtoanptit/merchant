import 'package:flutter/material.dart';
import 'package:merchant/widgets/productivity_button.dart';

class WorkTimerPage extends StatelessWidget {
  final double _defaultPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timer'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(_defaultPadding),
            ),
            Expanded(
              child: ProductivityButton(color: Colors.green, text: 'Work'),
            )
          ],
        ),
      ),
    );
  }
}
