import 'package:flutter/material.dart';

import 'login.dart';

class Phoneloginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Phoneloginpage();
  }
}

class _Phoneloginpage extends State<Phoneloginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 140.0, 0.0),
                  child: Text(
                    'Enter your',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 50.0, 140.0, 0.0),
                  child: Text(
                    'phone',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 100.0, 140.0, 0.0),
                  child: Text(
                    'number:',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Material(
                    elevation: 7.0,
                    borderRadius: BorderRadius.circular(15.0),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: (" Phone"),
                      ),
                      keyboardType: TextInputType.phone,
                    ))),
          ),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return login();
              }));
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
                  child: Text('NEXT STEP',
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
