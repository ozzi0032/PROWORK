import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileSubmitted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Are you sure'),
                  content: Text('Really want to leave the app?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ) ??
              false;
        },
        child: Material(
          color: Colors.white,
          child: Center(
            child: Text(
              "Your profile has been submitted. You will be redirected to Home Screen when our team will approve your profile.\nSorry for the inconvenience!",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
          ),
        ));
  }
}
