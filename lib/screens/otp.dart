import 'package:PROWORK/model/model_user.dart';
import 'package:PROWORK/services/helper/firebase.dart';
import 'package:PROWORK/utills/sharedPrefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PROWORK/widgets/appPrimaryButton.dart';
import '../serviceproviderprofile.dart';

class OtpScreen extends StatefulWidget {
  final args;
  final String mobileNumber;
  OtpScreen({this.args, @required this.mobileNumber})
      : assert(mobileNumber != null);
  @override
  State<StatefulWidget> createState() {
    return _OtpScreenState();
  }
}

class _OtpScreenState extends State<OtpScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseService _firebaseFunctions = FirebaseService();
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

  bool isCodeSent = false;
  String _verificationId;
  void showToast(message, Color color) {
    print(message);
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: TextStyle(
            color: color,
          ),
        ),
        duration: new Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 3.0,
        backgroundColor: color,
      ),
    );
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          // Handle loogged in state
          print(value.user.phoneNumber);
        } else {
          showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.red);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: widget.mobileNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: pinCode);
    UserCredential authResult =
        await _firebaseAuth.signInWithCredential(_authCredential);
    User user = authResult.user;
    if (user != null) {
      bool userExists = await _firebaseFunctions
          .checkUserExistance(user.phoneNumber.toString());
      if (!userExists) {
        UserModel newUser = new UserModel();
        newUser.phoneNumber = user.phoneNumber;
        await _firebaseFunctions.addUser(newUser);
      }
      //Set Login Session
      /*await*/ SharedPrefs.setLoginStatus();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ServiceProviderP(
                    phoneNumber: user,
                  )));
    } else {
      showToast('Error validating OTP, try again', Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
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
                    controller: _pin1Controller,
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin3FocuseNode);
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin4FocuseNode);
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin5FocuseNode);
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin6FocuseNode);
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
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
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ServiceProviderP();
              }));*/
              await _onFormSubmitted();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => MainTabs(
              //               isBuyer: widget.args["isBuyer"],
              //             )));
            },
            child: AppButton(title: 'Verify'),
          ),
        ],
      ),
    ))));
  }
}
