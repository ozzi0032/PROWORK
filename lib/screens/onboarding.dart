import 'package:PROWORK/widgets/appPrimaryButton.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnboardingScreenState();
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Background.jpg"),
                  fit: BoxFit.cover),
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
                          padding: EdgeInsets.fromLTRB(30.0, 275.0, 0.0, 0.0),
                          child: Text(
                            'Welcome to',
                            style: TextStyle(
                                fontSize: 55.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(85.0, 320.0, 0.0, 0.0),
                          child: Text(
                            'ProWork',
                            style: TextStyle(
                                fontSize: 50.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 385.0, 0.0, 0.0),
                          child: Text(
                            'The best way to discover and get you work done!',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(115.0, 435.0, 0.0, 0.0),
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
                        Navigator.pushNamed(context, '/phonelogin',
                            arguments: {"isBuyer": true});
                      },
                      child: AppButton(title: 'Customer')),
                  SizedBox(height: 30),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/phonelogin',
                            arguments: {"isBuyer": false});
                      },
                      child: AppButton(title: 'Service provider')),
                ],
              ),
            ))));
  }
}
