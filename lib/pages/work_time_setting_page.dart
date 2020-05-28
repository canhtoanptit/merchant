import 'package:flutter/material.dart';
import 'package:merchant/widgets/settings_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkTimeSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: WorkTimeSetting(),
    );
  }
}

class WorkTimeSetting extends StatefulWidget {
  @override
  _WorkTimeSettingPageState createState() {
    return _WorkTimeSettingPageState();
  }
}

class _WorkTimeSettingPageState extends State<WorkTimeSetting> {
  TextStyle textStyle = TextStyle(fontSize: 24);
  TextEditingController _txtWork;
  TextEditingController _txtShort;
  TextEditingController _txtLong;

  static const String WORK_TIME = "workTime";
  static const String SHORT_BREAK = "shortBreak";
  static const String LONG_BREAK = "longBreak";

  int workTime;
  int shortBreak;
  int longBreak;

  SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", -1),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
            Color(0xff009688),
            "+",
            1,
          ),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
            Color(0xff455A64),
            "-",
            -1,
          ),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(Color(0xff009688), "+", 1),
          Text(
            "Long",
            style: textStyle,
          ),
          Text(""),
          Text(""),
          SettingsButton(
            Color(0xff455A64),
            "-",
            -1,
          ),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
            Color(0xff009688),
            "+",
            1,
          ),
        ],
        padding: EdgeInsets.all(20.0),
      ),
    );
  }

  @override
  void initState() {
    _txtWork = TextEditingController();
    _txtShort = TextEditingController();
    _txtLong = TextEditingController();
    super.initState();
  }

  readSettings() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _txtWork.text = _sharedPreferences.getInt(WORK_TIME).toString();
      _txtShort.text = _sharedPreferences.getInt(SHORT_BREAK).toString();
      _txtLong.text = _sharedPreferences.getInt(LONG_BREAK).toString();
    });
  }
}
