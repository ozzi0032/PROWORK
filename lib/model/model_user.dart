class UserModel {
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
        'Profile': profile,
        'roleType': roleType,
        'status': status,
        'userId': userId
      };
}
