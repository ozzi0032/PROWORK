import 'package:flutter/material.dart';
import 'Splashscreen.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(fontFamily: 'Gibson', primarySwatch: Colors.cyan),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
