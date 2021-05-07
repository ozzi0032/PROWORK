import 'dart:io';
import 'package:PROWORK/model/model_user.dart';
import 'package:PROWORK/screens/phonelogin.dart';
import 'package:PROWORK/services/helper/firebase.dart';
import 'package:PROWORK/utills/sharedPrefs.dart';
import 'package:PROWORK/widgets/appPrimaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'tabbar.dart';
import 'package:provider/provider.dart';
import 'viewmodel/category_viewmodel.dart';
import 'package:path/path.dart';

class ServiceProviderP extends StatefulWidget {
  final User phoneNumber;
  ServiceProviderP({this.phoneNumber});
  @override
  State<StatefulWidget> createState() {
    return _ServiceProviderP();
  }
}

class _ServiceProviderP extends State<ServiceProviderP> {
  var selectedVal;
  var _skill;
  bool _visible1 = false, _visible2 = false;
  File _profileImage, _cnicFront, _cnicBack;
  String _profileURL, _cnicFrontURL, _cnicBackURL;
  UploadTask task;
  var shopId;
  FirebaseService _firebaseService = new FirebaseService();
  UserModel _userModel = new UserModel();
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  getUser() async {
    UserModel user =
        await _firebaseService.getUserSpecific(widget.phoneNumber.phoneNumber);
    if (user != null) {
      setState(() {
        _userModel = user;
      });
    }
  }

  createPersonalInfo() async {
    _userModel.fname = fNameController.text.toString();
    _userModel.lname = lNameController.text.toString();
    _userModel.phoneNumber = widget.phoneNumber.phoneNumber;
    _userModel.address = addressController.text.toString();
    _userModel.email = emailController.text.toString();
    await uploadPic(_profileImage, 1);
    _userModel.profileUrl = _profileURL;
    await uploadPic(_cnicFront, 2);
    _userModel.cnicFront = _cnicFrontURL;
    await uploadPic(_cnicBack, 3);
    _userModel.cnicBack = _cnicBackURL;
    await _firebaseService.updatePersonalInfo(_userModel);
    //set Flag User has added Personal Information
    SharedPrefs.setBasicInfoStatus(true);
  }

  _openGallary(BuildContext context, int picNo) async {
    // ignore: deprecated_member_use
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picNo == 1) {
        this._profileImage = pic;
      } else if (picNo == 2) {
        this._cnicFront = pic;
      } else if (picNo == 3) {
        this._cnicBack = pic;
      }
      //this._profileImage = pic;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context, int picNo) async {
    // ignore: deprecated_member_use
    var pic = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (picNo == 1) {
        this._profileImage = pic;
      } else if (picNo == 2) {
        this._cnicFront = pic;
      } else if (picNo == 3) {
        this._cnicBack = pic;
      }
      //this._profileImage = pic;
    });
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context, int picNo) {
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
                      _openGallary(context, picNo);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context, picNo);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future uploadPic(File image, int picNo) async {
    final fileName = basename(image.path);
    final destination = "images/$fileName";
    task = FirebaseService.uploadFile(destination, image);
    final snapshot = await task.whenComplete(() {});
    if (picNo == 1) {
      _profileURL = await snapshot.ref.getDownloadURL();
    } else if (picNo == 2) {
      _cnicFrontURL = await snapshot.ref.getDownloadURL();
    } else if (picNo == 3) {
      _cnicBackURL = await snapshot.ref.getDownloadURL();
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
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
              showChoiceDialog(context, 1);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black54,
              child: _profileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _profileImage,
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
                controller: fNameController,
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
                controller: lNameController,
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
                controller: addressController,
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
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: (" Email"),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    )))),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Material(
              elevation: 7,
              borderRadius: BorderRadius.circular(15.0),
              child: Consumer<CategoryViewModel>(
                builder: (context, model, child) {
                  return DropdownButton(
                    hint: Text("Select Skill"),
                    value: _skill,
                    isExpanded: false,
                    elevation: 7,
                    dropdownColor: Colors.cyan,
                    items: model.cat.map<DropdownMenuItem>((value) {
                      return DropdownMenuItem(
                        value: value.name,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _skill = value;
                      setState(() {
                        if (value == "Electrician") {
                          _visible1 = true;
                          _visible2 = false;
                        }
                        if (value == "Plumber") {
                          _visible1 = false;
                          _visible2 = true;
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Visibility(
          visible: _visible1,
          child: Consumer<CategoryViewModel>(
            builder: (context, model, child) {
              List<String> subCat = [];
              for (var cat in model.subCat) {
                if (cat.parentId == "cs1Pzjc50mzdjW3JLRca") {
                  subCat.add(cat.name);
                }
              }
              return CheckboxGroup(labels: subCat);
            },
          ),
        ),
        Visibility(
          visible: _visible2,
          child: Consumer<CategoryViewModel>(
            builder: (context, model, child) {
              List<String> subCat = [];
              for (var cat in model.subCat) {
                if (cat.parentId == "clbZ4CA6DwUx1gAUogT5") {
                  subCat.add(cat.name);
                }
              }
              return CheckboxGroup(labels: subCat);
            },
          ),
        ),
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
              showChoiceDialog(context, 2);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black54,
              child: _cnicFront != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _cnicFront,
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
              showChoiceDialog(context, 3);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black54,
              child: _cnicBack != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _cnicBack,
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
          onTap: () async {
            await createPersonalInfo();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MainTabs(
                          isBuyer: false,
                        )));
          },
          child: AppButton(title: 'Save'),
        ),
        Padding(padding: EdgeInsets.only(bottom: 30)),
      ],
    ));
  }
}
