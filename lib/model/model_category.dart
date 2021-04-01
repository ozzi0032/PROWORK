import 'package:PROWORK/model/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String parentId;
  String name;
  String description;
  CategoryModel({this.id, this.parentId, this.name, this.description});

  factory CategoryModel.fromFirestore(DocumentSnapshot ds) {
    var map = ds.data();
    return CategoryModel(
        id: ds.id, //Category Id from documentId
        parentId: map['ParentId'],
        name: map['Name'],
        description: map['Description']);
  }
}

class SkillsMapping {
  String uid;
  UserModel userModel;
  List<String> skills;
  SkillsMapping({this.userModel, this.uid, this.skills});

  factory SkillsMapping.fromFirestore(DocumentSnapshot ds) {
    var map = ds.data();
    return SkillsMapping(
        uid: map['userId'],
        userModel: UserModel.fromFirestore(map['user']),
        skills: map['skills']);
  }

  toJSON(SkillsMapping obj) {
    final data = obj.toMap();
    return data;
  }

  Map<String, dynamic> toMap() => {
        'userId': uid,
        'user': userModel.toMap(),
        'category': skills,
      };
}
