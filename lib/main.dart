import 'package:flutter/material.dart';
import 'Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
