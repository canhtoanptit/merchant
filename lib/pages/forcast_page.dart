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
      body: Center(
        child: Text("I'm here"),
      ),
    );
  }

}