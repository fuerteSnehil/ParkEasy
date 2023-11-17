class UserModel {
  String name;
  String email;
  String dob;

  // String createdAt;
  String phoneNumber;

  //String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.dob,

    //  required this.createdAt,
    required this.phoneNumber,
    // required this.uid,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      dob: map['bio'] ?? '',
      // uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      //  createdAt: map['createdAt'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      // "uid": uid,
      "dob": dob,
      "phoneNumber": phoneNumber,
      // "createdAt": createdAt,
    };
  }
}
