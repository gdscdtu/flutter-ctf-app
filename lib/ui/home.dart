import "package:flutter/material.dart";
import 'package:flutter_ctf_app/models/user_model.dart';
import 'package:flutter_ctf_app/services/firestore_database.dart';
import 'package:flutter_ctf_app/ui/level1/level1.dart';
import 'package:flutter_ctf_app/ui/unlocked_level_screen.dart';
import 'package:provider/provider.dart';

import 'level2/level2.dart';
import 'level3/level3.dart';

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
              child: _renderLevelScreen(level: user?.level),
            );
          }

          return const Center(
            child: Text("Home Screen"),
          );
        },
      ),
    );
  }

  Widget _renderLevelScreen({int? level}) {
    switch (level) {
      case 1:
        return Level1Screen(
          level: 1,
        );
      case 2:
        return Level2Screen(
          level: 2,
        );
      case 3:
        return Level3Screen(
          level: 3,
        );
      default:
        return const Center(
          child: Text("Home Screen"),
        );
    }
  }
}
