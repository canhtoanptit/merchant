import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {

  final Color color;
  final String text;
  final VoidCallback onPressed;

  ProductivityButton({this.color, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      color: this.color, onPressed: this.onPressed,
    );
  }

}