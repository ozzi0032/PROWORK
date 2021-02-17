import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  Button({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      height: 40.0,
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.cyanAccent,
        color: Colors.cyan,
        elevation: 7.0,
        child: Center(
          child: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
