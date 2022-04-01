import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/foundation.dart';
import 'package:flutter_ctf_app/services/firestore_path.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  late firebase.FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    //initialise object
    _auth = firebase.FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Create user object based on the given User
  UserModel _userFromFirebase(firebase.User? user) {
    if (user == null) {
      return UserModel(displayName: 'Null', uid: 'null');
    }

    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber ?? "",
        photoUrl: user.photoURL);
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(firebase.User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithGoogle() async {
    try {
      final account = await GoogleSignIn().signIn();

      _status = Status.Authenticating;
      notifyListeners();

      if (account == null) {
        return throw StateError('Maybe user canceled.');
      }
      final auth = await account.authentication;
      final firebase.AuthCredential authCredential =
          firebase.GoogleAuthProvider.credential(
        idToken: auth.idToken,
        accessToken: auth.accessToken,
      );

      final credential = await _auth.signInWithCredential(authCredential);

      final currentUser = firebase.FirebaseAuth.instance.currentUser;

      final reference =
          FirebaseFirestore.instance.doc(FirestorePath.user(currentUser!.uid));
      await reference.get().then((document) async => {
            if (!document.exists)
              {
                await FirestoreService.instance.set(
                    path: FirestorePath.user(credential.user!.uid),
                    data: _userFromFirebase(currentUser).toJson())
              }
          });
      // Set data for user in firebase

      assert(credential.user?.uid == currentUser?.uid);
      notifyListeners();

      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle user signing out
  Future signOut() async {
    return GoogleSignIn()
        .signOut()
        .then((_) => _auth.signOut())
        .catchError((error) {
      debugPrint(error.toString());
      throw error;
    });
  }
}
