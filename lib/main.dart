import 'package:flutter/material.dart';

import 'signup.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/candidate.jpg"), fit: BoxFit.cover),
            ),
            child: Center(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(30.0, 315.0, 0.0, 0.0),
                          child: Text(
                            'Welcome to',
                            style: TextStyle(
                                fontSize: 55.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(85.0, 375.0, 0.0, 0.0),
                          child: Text(
                            'ProWork',
                            style: TextStyle(
                                fontSize: 50.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 450.0, 0.0, 0.0),
                          child: Text(
                            'The best way to discover and get you work done!',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(115.0, 500.0, 0.0, 0.0),
                          child: Text(
                            'Continue With',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.cyanAccent,
                        color: Colors.cyan,
                        elevation: 7.0,
                        child: Center(
                          child: Text('EMAIL',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.blueGrey,
                        color: Colors.blueGrey[900],
                        elevation: 7.0,
                        child: Center(
                          child: Text('FACEBOOK',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))));
  }
}
