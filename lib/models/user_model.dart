import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? email;
  String? displayName;
  String? photoUrl;
  int? level;
  Timestamp? lastSubmit;
  bool? isBlocked;

  UserModel(
      {required this.uid,
      this.email,
      this.displayName,
      this.photoUrl,
      this.level = 1,
      this.lastSubmit,
      this.isBlocked});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    String uid = data['uid'];
    String email = data['email'];
    String displayName = data['displayName'];
    String photoUrl = data['photoUrl'];
    int level = data['level'];
    Timestamp lastSubmit = data['lastSubmit'];
    bool isBlocked = data['isBlocked'];

    return UserModel(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      level: level,
      lastSubmit: lastSubmit,
      isBlocked: isBlocked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'level': level,
      'lastSubmit': lastSubmit,
      'isBlocked': isBlocked,
    };
  }
}
