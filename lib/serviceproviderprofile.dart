import 'dart:io';

import 'package:PROWORK/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ServiceProviderP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ServiceProviderP();
  }
}

class _ServiceProviderP extends State<ServiceProviderP> {
  String _valskill;
  List _subskill = [
    "Tv Electrician",
    "Computer Electrician",
    "Home Electrician",
    "AC Electrician"
  ];
  File _image;
  _openGallary(BuildContext context) async {
    // ignore: deprecated_member_use
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this._image = pic;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var pic = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this._image = pic;
    });
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select From"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40),
            child: Text("Profile",
                style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              showChoiceDialog(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black54,
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              elevation: 7.0,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: (" First Name"),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              elevation: 7.0,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: (" Last Name"),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              elevation: 7.0,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: (" Address"),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              elevation: 7.0,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: (" City"),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              elevation: 7.0,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: (" state"),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
          ),
        ),
        Container(
            child: Padding(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
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
        Center(
            child: DropdownButton(
          hint: Text("Select your expertise"),
          value: _valskill,
          items: _subskill.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _valskill =
                  value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
            });
          },
        )),
        Padding(padding: EdgeInsets.only(bottom: 20)),
        Padding(
          padding: EdgeInsets.only(top: 40, left: 40, right: 40),
          child: Text("Enter front image of CNIC",
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.5,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              showChoiceDialog(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black54,
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 20)),
        Padding(
          padding: EdgeInsets.only(top: 40, left: 40, right: 40),
          child: Text("Enter back image of CNIC",
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.5,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              showChoiceDialog(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black54,
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 20)),
        SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return ServiceProviderhome();
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
                child: Text('Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 30)),
      ],
    ));
  }
}
