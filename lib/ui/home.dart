import "package:flutter/material.dart";
import 'package:flutter_ctf_app/models/user_model.dart';
import 'package:flutter_ctf_app/services/firestore_database.dart';
import 'package:flutter_ctf_app/ui/level1/level1.dart';
import 'package:provider/provider.dart';

import 'level2/level2.dart';
import 'level3/level3.dart';
import 'level4/level4.dart';
import 'level5/level5.dart';
import 'level6/level6.dart';
import 'level7/level7.dart';
import 'level8/level8.dart';
import 'level9/level9.dart';
import 'level10/level10.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireStoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      body: StreamBuilder(
        stream: fireStoreDatabase.userInformStream(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            UserModel? user = snapshot.data;
            return SafeArea(
              child: _renderLevelScreen(user: user!),
            );
          }

          return const MaterialApp(
            home: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _renderLevelScreen({required UserModel user}) {
    switch (user.level) {
      case 1:
        return Level1Screen(
          user: user,
        );
      case 2:
        return Level2Screen(
          user: user,
        );
      case 3:
        return Level3Screen(
          user: user,
        );
      case 4:
        return Level4Screen(
          user: user,
        );
      case 5:
        return Level5Screen(
          user: user,
        );
      case 6:
        return Level6Screen(
          user: user,
        );
      case 7:
        return Level7Screen(
          user: user,
        );
      case 8:
        return Level8Screen(
          user: user,
        );
      case 9:
        return Level9Screen(
          user: user,
        );
      case 10:
        return Level10Screen(
          user: user,
        );
      default:
        return const Center(
          child: Text("Home Screen"),
        );
    }
  }
}
