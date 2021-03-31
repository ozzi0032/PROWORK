import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './phonelogin.dart';
import './screens/splashscreen.dart';
import './screens/onboarding.dart';
import './screens/otp.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case '/phonelogin':
        return MaterialPageRoute(
            builder: (_) => Phoneloginpage(
                  args: settings.arguments,
                ));
      case '/otp':
        return MaterialPageRoute(
            builder: (_) => OtpScreen(
                  args: settings.arguments,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}
