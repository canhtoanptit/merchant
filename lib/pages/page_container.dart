import 'package:flutter/material.dart';
import 'package:merchant/models/app_settings.dart';
import 'package:merchant/pages/forcast_page.dart';

class PageContainer extends StatefulWidget {
  final AppSettings settings;

  PageContainer({Key key, this.settings}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageContainerState(settings);
  }
}

class _PageContainerState extends State<PageContainer> {
  final AppSettings settings;

  _PageContainerState(this.settings);

  @override
  Widget build(BuildContext context) {
    return ForecastPage();
  }
}
