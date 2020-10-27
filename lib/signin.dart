import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  elevation: 7.0,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: (" Name"),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ),
            ),
            Container(
                child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Material(
                        elevation: 7.0,
                        borderRadius: BorderRadius.circular(15.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: (" Email"),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        )))),
            Container(
                child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Material(
                        elevation: 7.0,
                        borderRadius: BorderRadius.circular(15.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: (" Password"),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        )))),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  shadowColor: Colors.cyanAccent,
                  color: Colors.cyan,
                  elevation: 7.0,
                  child: Center(
                    child: Text('CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
