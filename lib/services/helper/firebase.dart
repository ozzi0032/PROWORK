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
      return e;
    }
  }

  @override
  Future<List<TaskModel>> getTask(UserModel userModel) async {
    try {
      List<TaskModel> tasksList = [];
      var snapshot = await _firebaseFirestore
          .collection('Task')
          .where('employerId', isEqualTo: userModel.userId)
          .get();
      snapshot.docs.forEach((document) {
        tasksList.add(TaskModel.fromFirestore(document));
      });
      //tasksList = items.map((e) => TaskModel.fromFirestore(ds: e));
      return tasksList;
    } catch (e) {
      return e;
    }
  }

  //Notify Provider about the category specific tasks
  @override
  Future<List<TaskModel>> getTaskNotification(
      SkillsMapping skillsMapping) async {
    try {
      List<TaskModel> tasksList = [];
      var snapshot = await _firebaseFirestore
          .collection('Task')
          .where('category',
              arrayContains:
                  'Automotive') //, arrayContainsAny: skillsMapping.skills)
          .get();
      snapshot.docs.forEach((document) {
        if (document['status'] == 'unassigned') {
          tasksList.add(TaskModel.fromFirestore(document));
        }
      });
      return tasksList;
    } catch (e) {
      return e;
    }
  }

  @override
  Future<void> applyTask(TaskMapping taskMapping) async {
    try {
      await _firebaseFirestore
          .collection('Task Mapping')
          .doc()
          .set(taskMapping.toMap());
    } catch (e) {
      return e;
    }
  }

  @override
  Future<List<TaskMapping>> getTaskRequest(UserModel userModel) async {
    try {
      List<TaskMapping> tasksMapped = [];
      var snapshot = await _firebaseFirestore
          .collection('Task Mapping')
          .where('task.employerId', isEqualTo: userModel.userId)
          .get();
      snapshot.docs.forEach((document) {
        if (document['task']['status'] == 'unassigned') {
          tasksMapped.add(TaskMapping.fromFirestore(document));
        }
      });
      return tasksMapped;
    } catch (e) {
      return e;
    }
  }

  @override
  Future<void> acceptTaskReq(String id, TaskMapping taskMapping) async {
    try {
      var snapshot = await _firebaseFirestore
          .collection('Task Mapping')
          .where('employee.userId', isEqualTo: id)
          .limit(1)
          .get();
      DocumentReference dr =
          _firebaseFirestore.collection('TaskMapping').doc(snapshot.docs[0].id);
      await dr.set(taskMapping.toMap());

      //Now update the task status in the collection "Task"
      DocumentReference taskRef =
          _firebaseFirestore.collection('Task').doc(taskMapping.taskId);
      await taskRef.set(taskMapping.task);
    } catch (e) {
      return e;
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

  getMappedSkills(UserModel user) async {
    try {
      SkillsMapping mappedSkills;
      var snapshot = await _firebaseFirestore
          .collection('Skills Mapping')
          .where('userId', isEqualTo: user.userId)
          .limit(1)
          .get();
      mappedSkills = SkillsMapping.fromFirestore(snapshot.docs[0]);
      return mappedSkills;
    } catch (e) {
      return e;
    }
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
