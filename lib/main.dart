import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ctf_app/services/firestore_database.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(MyApp(
      databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
      key: const Key('MyApp'),
    ));
  });
}
