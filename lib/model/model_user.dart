import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String fname; //Map "Profile" key
  String lname; //Map "Profile" key
  String email; //Map "Profile" key
  String phoneNumber; //Map "Profile" key
  String profileUrl; //Map "Profile" key
  String address; //Map "Profile" key
  String cnicFront; //Map "Profile" key
  String cnicBack; //Map "Profile" key
  String userId;
  String roleType;
  String status;
  Map profile;
  UserModel({this.userId, this.roleType, this.status, this.profile});

  factory UserModel.fromFirestore(Map map) {
    return UserModel(
        userId: map['userId'],
        roleType: map['roleType'],
        status: map['status'],
        profile: map['profile']);
  }

  toJSON(UserModel obj) {
    final data = obj.toMap();
    return data;
  }

  Map<String, dynamic> toMap() => {
        'Profile': {
          'email': email,
          'fname': fname,
          'lname': lname,
          'phoneNumber': phoneNumber,
          'profileUrl': profileUrl,
          "address": address,
          "cnicFront": cnicFront,
          "cnciBack": cnicBack,
        },
        'roleType': roleType,
        'status': status,
        'userId': userId
      };
}
