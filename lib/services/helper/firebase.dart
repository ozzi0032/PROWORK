import 'package:PROWORK/model/model_category.dart';
import 'package:PROWORK/model/model_task.dart';
import 'package:PROWORK/services/index.dart';
import 'package:PROWORK/utills/appConstraints.dart';
import 'package:PROWORK/utills/sharedPrefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:PROWORK/model/model_user.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService implements BaseServices {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<CategoryModel> categories = [];

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      if (categories.isNotEmpty) {
        return categories;
      }
      List<CategoryModel> list = [];
      var snapshot = await _firebaseFirestore.collection('Categories').get();
      snapshot.docs.forEach((document) {
        list.add(CategoryModel.fromFirestore(document));
      });
      categories = list;
      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addTask(TaskModel taskModel) async {
    try {
      DocumentReference dr = _firebaseFirestore.collection('Task').doc();
      await dr.set(taskModel.toJSON(taskModel));
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future addUser(UserModel userModel) async {
    DocumentReference dr = _firebaseFirestore.collection('User').doc();
    await dr.set(userModel.toJSON(userModel)).whenComplete(() {
      SharedPrefs.setUserInfo(dr.id, userModel.phoneNumber);
      AppConstants.userDocIDConstant = dr.id;
      AppConstants.userPhoneNumberConstant = userModel.phoneNumber;
    });
  }

  Future<void> updatePersonalInfo(UserModel userModel) async {
    /*String uid = await SharedPrefs.getUserDocumentId();
    userModel.userId = uid;*/
    DocumentReference dr =
        _firebaseFirestore.collection('User').doc(userModel.userId);
    await dr.update(userModel.toJSON(userModel));
  }

  Future<bool> checkUserExistance(String number) async {
    bool status;
    await _firebaseFirestore
        .collection('User')
        //.where('PhoneNumber', isEqualTo: number)
        .where("Profile.phoneNumber", isEqualTo: number)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot != null && snapshot.docs.isNotEmpty) {
        status = true;
      } else {
        status = false;
      }
    });
    //status = false;
    return status;
  }

  getUserSpecific(String phoneNumber) async {
    var snapshot = await _firebaseFirestore
        .collection('User')
        .where('Profile.phoneNumber', isEqualTo: phoneNumber)
        .limit(1)
        .get();
    if (snapshot.docs.length > 0) {
      DocumentSnapshot ds = snapshot.docs[0];
      UserModel user = UserModel.fromFirestore(ds.data());
      user.userId = ds.id;
      return user;
    } else
      return false;
  }

  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future mapSkill(List<String> categories, Map userData) async {
    DocumentReference dr =
        _firebaseFirestore.collection("Skills Mapping").doc(userData["userId"]);
    await dr.set({
      "userId": userData["userId"],
      "user": userData["Profile"],
      "category": categories
    });
  }

  Future<void> updateSkillMap(List<String> categories, Map userData) async {
    DocumentReference dr =
        _firebaseFirestore.collection("Skills Mapping").doc(userData["userId"]);
    await dr.update({
      "userId": userData["userId"],
      "user": userData["Profile"],
      "category": categories
    });
  }

  Future<bool> checkSkill(String userId) async {
    bool status;
    await _firebaseFirestore
        .collection("Skills Mapping")
        .where("userId", isEqualTo: userId)
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot != null && snapshot.docs.isNotEmpty) {
        status = true;
      } else {
        status = false;
      }
    });
    return status;
  }

  Future<bool> checkProviderStatus(String id) async {
    bool status = false;
    var snapshot = await _firebaseFirestore
        .collection('User')
        .where('userId', isEqualTo: id)
        .limit(1)
        .get();
    DocumentSnapshot snap = snapshot.docs[0];
    String statusType = snap.get("status");
    if (statusType == "approved") {
      status = true;
      return status;
    }
    return status;
  }
}
