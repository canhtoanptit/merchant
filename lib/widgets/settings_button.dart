import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callbackSetting;

  SettingsButton(this.color, this.text, this.value, this.size, this.setting,
      this.callbackSetting);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => this.callbackSetting(this.setting, this.value),
      color: this.color,
      minWidth: this.size,
    );
  }
}
