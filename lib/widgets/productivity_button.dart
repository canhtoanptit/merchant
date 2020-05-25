import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {

  final Color color;
  final String text;


  ProductivityButton({this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      color: this.color, onPressed: () {  },
    );
  }

}