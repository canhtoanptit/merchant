import 'package:flutter/material.dart';
import 'package:merchant/utils/flutter_ui_utils.dart' as ui;
import 'package:merchant/widgets/transition_appbar.dart';

class ForecastPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForecastPageState();
  }
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ui.appBarHeight(context)),
          child: TransitionAppbar(),
        ),
        body: Builder(
            builder: (context) => Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "I'm here",
                          style: TextStyle(
                              fontSize: 20, color: Colors.deepPurpleAccent),
                        )),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.network(
                          'https://cdn4.iconfinder.com/data/icons/new-google-logo-2015/400/new-google-favicon-512.png',
                          height: 100,
                          width: 100,
                        )),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        child: Text('Contact us'),
                        onPressed: () => _contactUs(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        child: Text('Work Timer'),
                        onPressed: () => Navigator.pushNamed(context, '/work-timer'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        child: Text('Ping Pong'),
                        onPressed: () => Navigator.pushNamed(context, '/ping-pong'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        child: Text('Movies'),
                        onPressed: () => Navigator.pushNamed(context, '/movies'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        child: Text('Shopping'),
                        onPressed: () => Navigator.pushNamed(context, '/shop'),
                      ),
                    )
                  ]),
                ))));
  }

  void _contactUs(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hello im here!'),
            content: Text('Mail us at abc@gmail.com'),
            actions: <Widget>[
              FlatButton(
                child: Text('close'),
                onPressed: () => Navigator.pushNamed(context, '/measure-converter'),
              )
            ],
          );
        });
  }
}
