import 'package:flutter/material.dart';
import 'package:merchant/models/timer_model.dart';
import 'package:merchant/pages/work_time_setting_page.dart';
import 'package:merchant/utils/time_utils.dart';
import 'package:merchant/widgets/productivity_button.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkTimerPage extends StatelessWidget {
  final double _defaultPadding = 5.0;
  final CountDownTimer _countDownTimer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    _countDownTimer.startWork();
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: <Widget>[
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return menuItems.toList();
              },
              onSelected: (value) => {
                if (value == 'Settings')
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkTimeSettingPage()))
                  }
              },
            )
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: "Work",
                          onPressed: () => _countDownTimer.startWork())),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff607D8B),
                          text: "Short Break",
                          onPressed: () => _countDownTimer.startBreak(true))),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff455A64),
                          text: "Long Break",
                          onPressed: () => _countDownTimer.startBreak(false))),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                      initialData: '00:00',
                      stream: _countDownTimer.stream(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        TimerModel timer = (snapshot.data == '00:00')
                            ? TimerModel('00:00', 1)
                            : snapshot.data;
                        return Expanded(
                            child: CircularPercentIndicator(
                          radius: availableWidth / 2,
                          lineWidth: 10.0,
                          percent: timer.percent,
                          center: Text(timer.time,
                              style: Theme.of(context).textTheme.headline4),
                          progressColor: Color(0xff009688),
                        ));
                      })),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff212121),
                          text: 'Stop',
                          onPressed: () => _countDownTimer.stopTimer())),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: 'Restart',
                          onPressed: () => _countDownTimer.startTimer())),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                ],
              )
            ],
          );
        }));
  }
}
