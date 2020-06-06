import 'package:flutter/material.dart';
import 'package:merchant/models/app_settings.dart';
import 'package:merchant/pages/launch_page.dart';
import 'package:merchant/pages/measure_converter.dart';
import 'package:merchant/pages/movies_page.dart';
import 'package:merchant/pages/page_container.dart';
import 'package:merchant/pages/ping_pong_page.dart';
import 'package:merchant/pages/shopping_page.dart';
import 'package:merchant/pages/treasure_map_page.dart';
import 'package:merchant/pages/work_timer_page.dart';
import 'package:merchant/styles.dart';

void main() {
  AppSettings settings = AppSettings();
  runApp(MyApp(
    appSettings: settings,
  ));
}

class MyApp extends StatelessWidget {
  final AppSettings appSettings;

  MyApp({Key key, this.appSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
        fontFamily: "Cabin",
        primaryColor: AppColor.midnightSky,
        accentColor: AppColor.midnightCloud,
        primaryTextTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColor.textColorDark,
            displayColor: AppColor.textColorDark),
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColor.textColorDark,
            displayColor: AppColor.textColorDark));

    return MaterialApp(
      title: 'Merchant App',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: {
        '/measure-converter': (context) => MeasureConverter(),
        '/work-timer': (context) => WorkTimerPage(),
        '/ping-pong': (context) => PingPongPage(),
        '/movies': (context) => MoviesPage(),
        '/shop': (context) => ShoppingPage(),
        '/event': (context) => LaunchPage(),
        '/treasure': (context) => TreasureMapPage()
      },
      home: PageContainer(settings: appSettings),
    );
  }
}
