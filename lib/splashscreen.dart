import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  timer() async {
    var _duration = new Duration(seconds: 1);
    return Timer(
      _duration,
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return login();
        }));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage('assets/pro work 2.jpg'),
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
