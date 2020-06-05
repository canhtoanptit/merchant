import 'package:flutter/material.dart';
import 'package:merchant/pages/event_detail_page.dart';
import 'package:merchant/pages/login_page.dart';
import 'package:merchant/shared/authentication.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() {
    return _LaunchPageState();
  }
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Authentication auth = Authentication();
    auth.getUser().then((user) {
      MaterialPageRoute route;
      if (user != null) {
        route = MaterialPageRoute(builder: (context) => EventDetailPage(user.uid));
      } else {
        route = MaterialPageRoute(builder: (context) => LoginPage());
      }
      Navigator.push(context, route);
    }).catchError((err) => print(err));
  }
}
