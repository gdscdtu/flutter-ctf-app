class UserModel {
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  int? level;

  UserModel(
      {required this.uid,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.photoUrl,
      this.level});

  factory UserModel.fromJson(Map<String, dynamic> data, String documentId) {
    String email = data['email'];
    String displayName = data['displayName'];
    String phoneNumber = data['phoneNumber'];
    String photoUrl = data['photoUrl'];
    int level = data['level'];

    return UserModel(
        uid: documentId,
        email: email,
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
        level: level);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'level': level,
    };
  }
}