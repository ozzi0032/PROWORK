import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Otp();
  }
}

class _Otp extends State<OtpScreen> {
  FocusNode pin2FocuseNode;
  FocusNode pin3FocuseNode;
  FocusNode pin4FocuseNode;
  FocusNode pin5FocuseNode;
  FocusNode pin6FocuseNode;
  @override
  void initState() {
    super.initState();
    pin2FocuseNode = FocusNode();
    pin3FocuseNode = FocusNode();
    pin4FocuseNode = FocusNode();
    pin5FocuseNode = FocusNode();
    pin6FocuseNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocuseNode.dispose();
    pin3FocuseNode.dispose();
    pin4FocuseNode.dispose();
    pin5FocuseNode.dispose();
    pin6FocuseNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

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
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Text(
              'Enter 6 digits verification code sent to your number',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin2FocuseNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    focusNode: pin2FocuseNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin3FocuseNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    focusNode: pin3FocuseNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin4FocuseNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    focusNode: pin4FocuseNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin5FocuseNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    focusNode: pin5FocuseNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin6FocuseNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    focusNode: pin6FocuseNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      pin6FocuseNode.unfocus();
                    },
                  ),
                ),
              ])),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
                  child: Text('Veify',
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
