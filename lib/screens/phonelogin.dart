import 'package:PROWORK/screens/otp.dart';
import 'package:PROWORK/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:PROWORK/widgets/appPrimaryButton.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Phoneloginpage extends StatefulWidget {
  final args;
  Phoneloginpage({this.args});
  @override
  State<StatefulWidget> createState() {
    return _Phoneloginpage();
  }
}

class _Phoneloginpage extends State<Phoneloginpage> {
  TextEditingController controller = new TextEditingController();
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
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 140.0, 0.0),
            child: Text(
              'Enter your\nphone number',
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
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
                      controller: controller,
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
              final phone = controller.text.trim();
              //Navigator.pushNamed(context, '/otp', arguments: widget.args);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OtpScreen(mobileNumber:phone)));
            },
            child: AppButton(title: 'NEXT STEP'),
          )
        ],
      ),
    ))));
  }
}
