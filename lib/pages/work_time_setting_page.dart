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
          SettingsButton(
              Color(0xff455A64), "-", -1, 24, WORK_TIME, updateSetting),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
              Color(0xff009688), "+", 1, 24, WORK_TIME, updateSetting),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
              Color(0xff455A64), "-", -1, 24, SHORT_BREAK, updateSetting),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
              Color(0xff009688), "+", 1, 24, SHORT_BREAK, updateSetting),
          Text(
            "Long",
            style: textStyle,
          ),
          Text(""),
          Text(""),
          SettingsButton(
              Color(0xff455A64), "-", -1, 24, LONG_BREAK, updateSetting),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
              Color(0xff009688), "+", 1, 24, LONG_BREAK, updateSetting),
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
    readSettings();
    super.initState();
  }

  readSettings() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    int workTime = _sharedPreferences.getInt(WORK_TIME);
    if (workTime == null) {
      await _sharedPreferences.setInt(WORK_TIME, int.parse('30'));
    }
    int shortBreak = _sharedPreferences.getInt(SHORT_BREAK);
    if (shortBreak == null) {
      await _sharedPreferences.setInt(SHORT_BREAK, int.parse('5'));
    }
    int longBreak = _sharedPreferences.getInt(LONG_BREAK);
    if (longBreak == null) {
      await _sharedPreferences.setInt(LONG_BREAK, int.parse('20'));
    }
    setState(() {
      _txtWork.text = _sharedPreferences.getInt(WORK_TIME).toString();
      _txtShort.text = _sharedPreferences.getInt(SHORT_BREAK).toString();
      _txtLong.text = _sharedPreferences.getInt(LONG_BREAK).toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORK_TIME:
        {
          int workTime = _sharedPreferences.getInt(WORK_TIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            _sharedPreferences.setInt(WORK_TIME, value);
            setState(() {
              _txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORT_BREAK:
        {
          int short = _sharedPreferences.getInt(SHORT_BREAK);
          short += value;
          if (short >= 1 && short <= 120) {
            _sharedPreferences.setInt(SHORT_BREAK, short);
            setState(() {
              _txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONG_BREAK:
        {
          int long = _sharedPreferences.getInt(LONG_BREAK);
          long += value;
          if (long >= 1 && long <= 180) {
            _sharedPreferences.setInt(LONG_BREAK, long);
            setState(() {
              _txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
