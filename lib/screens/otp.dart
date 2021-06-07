import 'package:PROWORK/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:PROWORK/widgets/appPrimaryButton.dart';
import 'package:provider/provider.dart';
import '../profileCompletion.dart';

class OtpScreen extends StatefulWidget {
  final args;
  OtpScreen({@required this.args}) : assert(args != null);
  @override
  State<StatefulWidget> createState() {
    return _OtpScreenState();
  }
}

class _OtpScreenState extends State<OtpScreen> {
  FocusNode pin2FocuseNode;
  FocusNode pin3FocuseNode;
  FocusNode pin4FocuseNode;
  FocusNode pin5FocuseNode;
  FocusNode pin6FocuseNode;
  TextEditingController _pin1Controller = TextEditingController();
  TextEditingController _pin2Controller = TextEditingController();
  TextEditingController _pin3Controller = TextEditingController();
  TextEditingController _pin4Controller = TextEditingController();
  TextEditingController _pin5Controller = TextEditingController();
  TextEditingController _pin6Controller = TextEditingController();
  String pinCode = '';

  // void showToast(message, Color color) {
  //   print(message);
  //   // ignore: deprecated_member_use
  //   Scaffold.of(context).showSnackBar(
  //     new SnackBar(
  //       content: new Text(
  //         message,
  //         style: TextStyle(
  //           color: color,
  //         ),
  //       ),
  //       duration: new Duration(seconds: 2),
  //       behavior: SnackBarBehavior.floating,
  //       elevation: 3.0,
  //       backgroundColor: color,
  //     ),
  //   );
  // }

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
                child: Consumer<UserViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: model.isLoading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        'Enter 6 digits verification code sent to your number',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
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
                            controller: _pin1Controller,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 24),
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onChanged: (value) {
                              nextField(
                                  value: value, focusNode: pin2FocuseNode);
                              setState(() {
                                pinCode = _pin1Controller.text;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: TextFormField(
                            controller: _pin2Controller,
                            focusNode: pin2FocuseNode,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 24),
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onChanged: (value) {
                              nextField(
                                  value: value, focusNode: pin3FocuseNode);
                              setState(() {
                                pinCode += _pin2Controller.text;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: TextFormField(
                            controller: _pin3Controller,
                            focusNode: pin3FocuseNode,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 24),
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onChanged: (value) {
                              nextField(
                                  value: value, focusNode: pin4FocuseNode);
                              setState(() {
                                pinCode += _pin3Controller.text;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: TextFormField(
                            controller: _pin4Controller,
                            focusNode: pin4FocuseNode,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 24),
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onChanged: (value) {
                              nextField(
                                  value: value, focusNode: pin5FocuseNode);
                              setState(() {
                                pinCode += _pin4Controller.text;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: TextFormField(
                            controller: _pin5Controller,
                            focusNode: pin5FocuseNode,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 24),
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onChanged: (value) {
                              nextField(
                                  value: value, focusNode: pin6FocuseNode);
                              setState(() {
                                pinCode += _pin5Controller.text;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: TextFormField(
                            controller: _pin6Controller,
                            focusNode: pin6FocuseNode,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 24),
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                focusedBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onChanged: (value) {
                              pin6FocuseNode.unfocus();
                              setState(() {
                                pinCode += _pin6Controller.text;
                              });
                            },
                          ),
                        ),
                      ])),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () async {
                      await model.onVerify(pinCode).then((_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileCompletion(
                                      phoneNumber: widget.args['phoneNumber'],
                                      isBuyer: widget.args['isBuyer'],
                                    )));
                      }).onError((error, stackTrace) {
                        //showToast(error.toString(), Colors.red);
                        print('OTP ERROR => || ' + error.toString());
                      });
                    },
                    child: AppButton(title: 'Verify'),
                  ),
                ],
              ),
      ),
    ))));
  }
}
