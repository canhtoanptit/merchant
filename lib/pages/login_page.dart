import 'package:flutter/material.dart';
import 'package:merchant/pages/event_detail_page.dart';
import 'package:merchant/shared/authentication.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginInfo(),
    );
  }
}

class LoginInfo extends StatefulWidget {
  @override
  _LoginInfoState createState() {
    return _LoginInfoState();
  }
}

class _LoginInfoState extends State<LoginInfo> {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  bool _isLogin = false;
  Authentication auth;
  String _userId;
  String _password;
  String _email;
  String _errorMessage = "";

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                emailInput(),
                passwordInput(),
                mainButton(),
                secondaryButton(),
                validationMessage()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: 'Email', icon: Icon(Icons.email)),
        validator: (text) => text.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: TextFormField(
          controller: txtPassword,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'password', icon: Icon(Icons.enhanced_encryption)),
          validator: (text) => text.isEmpty ? 'Password is required' : '',
        ));
  }

  Widget mainButton() {
    String buttonText = this._isLogin ? 'Login' : 'Sign up';
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: Container(
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).accentColor,
              elevation: 3,
              child: Text(buttonText),
              onPressed: () => submit(),
            )));
  }

  Widget secondaryButton() {
    String buttonText = !_isLogin ? 'Login' : 'Sign up';
    return FlatButton(
      child: Text(buttonText),
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
    );
  }

  Widget validationMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Future submit() async {
    setState(() {
      _errorMessage = "";
    });
    try {
      if (_isLogin) {
        _userId = await auth.login(txtEmail.text, txtPassword.text);
        print('Login for user $_userId');
      } else {
        _userId = await auth.signUp(txtEmail.text, txtPassword.text);
        print('Sign up for user $_userId');
      }
      if (_userId != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventDetailPage()));
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _errorMessage = e.message;
      });
    }
  }
}
