class UserModel {
  String fname; //Map "Profile" value
  String lname; //Map "Profile" value
  String email; //Map "Profile" value
  String phoneNumber; //Map "Profile" value
  String profileUrl; //Map "Profile" value
  String address; //Map "Profile" value
  String cnicFront; //Map "Profile" value
  String cnicBack; //Map "Profile" value
  String userId;
  String roleType;
  String status;
  UserModel(
      {this.userId,
      this.roleType,
      this.status,
      this.fname,
      this.lname,
      this.email,
      this.phoneNumber,
      this.profileUrl,
      this.address,
      this.cnicFront,
      this.cnicBack});

  factory UserModel.fromFirestore(Map map) {
    return UserModel(
      userId: map['userId'],
      roleType: map['roleType'],
      status: map['status'],
      fname: map['Profile']['fname'],
      lname: map['Profile']['lname'],
      phoneNumber: map['Profile']['phoneNumber'],
      email: map['Profile']['email'],
      profileUrl: map['Profile']['profileUrl'],
      address: map['Profile']['address'],
      cnicFront: map['Profile']['cnicFront'],
      cnicBack: map['Profile']['cnciBack'],
    );
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
