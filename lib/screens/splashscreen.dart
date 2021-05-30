import 'package:PROWORK/model/model_user.dart';
import 'package:PROWORK/tabbar.dart';
import 'package:PROWORK/viewmodel/category_viewmodel.dart';
import 'package:PROWORK/viewmodel/user_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  FirebaseAuth _auth;
  User _user;
  bool exist = false;
  timer() async {
    var _duration = Duration(seconds: 3);
    return Timer(
      _duration,
      () {
        if (_user == null && exist == true) {
          Navigator.pushReplacementNamed(context, '/onboarding');
        } else if (_user != null && exist == true) {
          Navigator.pushReplacementNamed(context, '/onboarding');
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => MainTabs(
                        isBuyer: false,
                      )));
        }
        //Navigator.pushReplacementNamed(context, '/onboarding');
      },
    );
  }

  loadInitData() async {
    Provider.of<CategoryViewModel>(context, listen: false).getCategories();
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
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
            child: Consumer<UserViewModel>(
              builder: (context, model, child) {
                model.loadUser();
                if (model.user == null) {
                  exist = true;
                }
                return Image(
                  image: AssetImage('assets/images/app_logo.png'),
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
        ));
  }
}
