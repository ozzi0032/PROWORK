import 'package:PROWORK/utills/exceptions.dart';
import 'package:PROWORK/viewmodel/user_viewmodel.dart';
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
                child: Consumer<UserViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: model.isLoading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, /*140.0*/ 0.0, 0.0),
                    child: FittedBox(
                      child: Text(
                        'Enter your phone number',
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold),
                      ),
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
                              controller: controller..text = "+92",
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
                    onTap: () async {
                      try {
                        if (controller.text.length != 13) {
                          throw CustomeExceptions("Phone number is not valid!");
                        }
                        final phone = controller.text.trim();
                        await model.initOTP(phone).then((_) {
                          Navigator.pushNamed(context, '/otp', arguments: {
                            'isBuyer': widget.args['isBuyer'],
                            'phoneNumber': phone,
                          });
                        }).onError((error, stackTrace) => null);
                      } on CustomeExceptions catch (e) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Error Occured"),
                                  content: Text(e.error),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ));
                      }
                    },
                    child: AppButton(title: 'NEXT STEP'),
                  )
                ],
              ),
      ),
    ))));
  }
}
