import 'package:PROWORK/viewmodel/category_viewmodel.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  timer() async {
    var _duration = Duration(seconds: 3);
    return Timer(
      _duration,
      () {
        Navigator.pushReplacementNamed(context, '/onboarding');
      },
    );
  }

  loadInitData() async {
    Provider.of<CategoryViewModel>(context, listen: false).getCategories();
  }

  @override
  void initState() {
    super.initState();
    timer();
    loadInitData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage('assets/images/app_logo.png'),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
