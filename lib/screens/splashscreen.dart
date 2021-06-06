import 'package:PROWORK/service_locator.dart';
import 'package:PROWORK/tabbar.dart';
import 'package:PROWORK/utills/sharedPrefs.dart';
import 'package:PROWORK/viewmodel/category_viewmodel.dart';
import 'package:PROWORK/viewmodel/user_viewmodel.dart';
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
  final userViewModel = serviceLocator.get<UserViewModel>();
  bool isLoggedIn = false;
  timer() async {
    var _duration = Duration(seconds: 4);
    return Timer(
      _duration,
      () {
        if (isLoggedIn &&
            userViewModel.user != null &&
            userViewModel.user.roleType == 'buyer') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => MainTabs(
                        isBuyer: true,
                      )));
        } else if (isLoggedIn &&
            userViewModel.user != null &&
            userViewModel.user.roleType == 'provider') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => MainTabs(
                        isBuyer: false,
                      )));
        } else {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      },
    );
  }

  loadInitData() async {
    isLoggedIn = await SharedPrefs.getLoginStatus();
    await userViewModel.loadUser();
    Provider.of<CategoryViewModel>(context, listen: false).getCategories();
  }

  @override
  void initState() {
    super.initState();
    loadInitData();
    timer();
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
            )),
      ),
    );
  }
}
