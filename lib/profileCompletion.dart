import 'dart:io';
import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/model/model_user.dart';
import 'package:PROWORK/profileSubmitted.dart';
import 'package:PROWORK/services/helper/firebase.dart';
import 'package:PROWORK/utills/exceptions.dart';
import 'package:PROWORK/utills/sharedPrefs.dart';
import 'package:PROWORK/viewmodel/user_viewmodel.dart';
import 'package:PROWORK/widgets/appPrimaryButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'tabbar.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class UserProfileCompletion extends StatefulWidget {
  final String phoneNumber;
  final bool isBuyer;
  UserProfileCompletion({this.phoneNumber, this.isBuyer});
  @override
  State<StatefulWidget> createState() {
    return _UserProfileCompletionState();
  }
}

class _UserProfileCompletionState extends State<UserProfileCompletion> {
  bool isLoading = false;
  var selectedVal;
  var _skill;
  bool _visible1 = false, _visible2 = false;
  File _profileImage, _cnicFront, _cnicBack;
  String _profileURL, _cnicFrontURL, _cnicBackURL;
  UploadTask task;
  FirebaseService _firebaseService = new FirebaseService();
  UserModel _userModel = new UserModel();
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  List<String> _checked1 = [], _checked2 = [];
  List<CategoryModel> categoriesList = [];

  getUser() async {
    UserModel user = await _firebaseService.getUserSpecific(widget.phoneNumber);
    if (user != null) {
      setState(() {
        _userModel = user;
      });
    }
  }

  createPersonalInfoBuyer() async {
    _userModel.fname = fNameController.text.toString();
    _userModel.lname = lNameController.text.toString();
    _userModel.phoneNumber = widget.phoneNumber;
    _userModel.address = addressController.text.toString();
    _userModel.email = emailController.text.toString();
    _userModel.roleType = 'buyer';
    _userModel.status = 'approved';
    await uploadPic(_profileImage, 1);
    _userModel.profileUrl = _profileURL;
    await _firebaseService.updatePersonalInfo(_userModel);
    //set Flag User has added Personal Information
    SharedPrefs.setBasicInfoStatus(true);
  }

  createPersonalInfoProvider() async {
    _userModel.fname = fNameController.text.toString();
    _userModel.lname = lNameController.text.toString();
    _userModel.phoneNumber = widget.phoneNumber;
    _userModel.address = addressController.text.toString();
    _userModel.email = emailController.text.toString();
    _userModel.roleType = 'provider';
    _userModel.status = 'pending';
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

  mapskill() async {
    if (_skill == "Electrician") {
      _firebaseService.mapSkill(_checked1, _userModel.toMap());
    } else if (_skill == "Plumber") {
      _firebaseService.mapSkill(_checked2, _userModel.toMap());
    }
  }

  updateSkill() async {
    if (_skill == "Electrician") {
      _firebaseService.mapSkill(_checked1, _userModel.toMap());
    } else if (_skill == "Plumber") {
      _firebaseService.mapSkill(_checked2, _userModel.toMap());
    }
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

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
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
        widget.isBuyer
            ? Container()
            : Container(
                child: Padding(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(15.0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Categories")
                          .where("ParentId", isEqualTo: "0")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return DropdownButton(
                          isExpanded: false,
                          elevation: 7,
                          dropdownColor: Colors.grey,
                          items: snapshot.data.docs.map((value) {
                            return DropdownMenuItem(
                              value: value.get("Name"),
                              child: Text("${value.get("Name")}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                _skill = value;
                                if (_skill == "Electrician") {
                                  _visible1 = true;
                                  _visible2 = false;
                                }
                                if (_skill == "Plumber") {
                                  _visible1 = false;
                                  _visible2 = true;
                                }
                              },
                            );
                          },
                          value: _skill,
                          hint: new Text("Select Skill"),
                        );
                      }),
                ),
              )),
        widget.isBuyer ? Container() : SizedBox(height: 30),
        Visibility(
          visible: _visible1,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Categories")
                .where("ParentId", isEqualTo: "cs1Pzjc50mzdjW3JLRca")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              List<String> _subSkill = [];
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                DocumentSnapshot snap = snapshot.data.docs[i];
                _subSkill.add(snap.get("Name"));
              }
              return CheckboxGroup(
                labels: _subSkill,
                onSelected: (List<String> selected) {
                  setState(() {
                    _checked1 = selected;
                  });
                },
                checked: _checked1,
              );
            },
          ),
        ),
        Visibility(
          visible: _visible2,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Categories")
                .where("ParentId", isEqualTo: "clbZ4CA6DwUx1gAUogT5")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              List<String> _subSkill = [];
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                DocumentSnapshot snap = snapshot.data.docs[i];
                _subSkill.add(snap.get("Name"));
              }
              return CheckboxGroup(
                labels: _subSkill,
                onSelected: (List<String> selected) {
                  setState(() {
                    _checked2 = selected;
                  });
                },
                checked: _checked2,
              );
            },
          ),
        ),
        widget.isBuyer
            ? Container()
            : Padding(padding: EdgeInsets.only(bottom: 20)),
        widget.isBuyer
            ? Container()
            : Padding(
                padding: EdgeInsets.only(top: 40, left: 40, right: 40),
                child: Text("Enter front image of CNIC",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
              ),
        widget.isBuyer
            ? Container()
            : SizedBox(
                height: 32,
              ),
        widget.isBuyer
            ? Container()
            : Center(
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
        widget.isBuyer
            ? Container()
            : Padding(padding: EdgeInsets.only(bottom: 20)),
        widget.isBuyer
            ? Container()
            : Padding(
                padding: EdgeInsets.only(top: 40, left: 40, right: 40),
                child: Text("Enter back image of CNIC",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
              ),
        widget.isBuyer
            ? Container()
            : SizedBox(
                height: 32,
              ),
        widget.isBuyer
            ? Container()
            : Center(
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
        Consumer<UserViewModel>(
          builder: (context, model, child) {
            return isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    onTap: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        if (widget.isBuyer) {
                          if (fNameController == null ||
                              lNameController == null ||
                              emailController == null ||
                              addressController == null ||
                              _profileImage == null) {
                            throw CustomeExceptions(
                                "Some important field is null");
                          }
                          if (fNameController.text.length < 4) {
                            throw CustomeExceptions(
                                "First name length should 4 or more...");
                          }
                          if (lNameController.text.length < 4) {
                            throw CustomeExceptions(
                                "Last name length should 4 or more...");
                          }
                          if (addressController.text.length < 10) {
                            throw CustomeExceptions(
                                "Address should be greater than 10 words");
                          }
                          if (validateEmail(emailController.text) == false) {
                            throw CustomeExceptions("Enter a valid Email");
                          }

                          bool status = await _firebaseService
                              .checkUserExistance(widget.phoneNumber);
                          status
                              ? await createPersonalInfoBuyer()
                              : await _firebaseService.addUser(_userModel);
                          await model.saveUser(_userModel);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MainTabs(
                                        isBuyer: true,
                                      )));
                        } else {
                          if (fNameController == null ||
                              lNameController == null ||
                              emailController == null ||
                              addressController == null ||
                              _profileImage == null ||
                              _cnicFront == null ||
                              _cnicBack == null) {
                            throw CustomeExceptions(
                                "Some important field is null");
                          }
                          if (fNameController.text.length < 4) {
                            throw CustomeExceptions(
                                "First name length should 4 or more...");
                          }
                          if (lNameController.text.length < 4) {
                            throw CustomeExceptions(
                                "Last name length should 4 or more...");
                          }
                          if (addressController.text.length < 10) {
                            throw CustomeExceptions(
                                "Address should be greater than 10 words");
                          }
                          if (validateEmail(emailController.text) == false) {
                            throw CustomeExceptions("Enter a valid Email");
                          }
                          await createPersonalInfoProvider();
                          bool status = await _firebaseService
                              .checkSkill(_userModel.userId);
                          if (status == true) {
                            await updateSkill();
                          } else {
                            await mapskill();
                          }
                          await model.saveUser(_userModel);
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MainTabs(
                                        isBuyer: false,
                                      )));*/
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfileSubmitted()));
                        }
                      } on CustomeExceptions catch (e) {
                        setState(() {
                          isLoading = false;
                        });
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
                    child: AppButton(title: 'Save'),
                  );
          },
        ),
        Padding(padding: EdgeInsets.only(bottom: 30)),
      ],
    ));
  }
}
