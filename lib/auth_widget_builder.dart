import 'package:flutter/material.dart';
import 'package:flutter_ctf_app/services/firestore_database.dart';
import 'package:provider/provider.dart';

import 'consts/global.dart';
import 'models/user_model.dart';

/*
* This class is mainly to help with creating user dependent object that
* need to be available by all downstream widgets.
* Thus, this widget builder is a must to live above [MaterialApp].
* As we rely on uid to decide which main screen to display (eg: Home or Sign In),
* this class will helps to create all providers needed that depends on
* the user logged data uid.
 */

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder(
      {required Key key, required this.builder, required this.databaseBuilder})
      : super(key: key);
  final Widget Function(BuildContext) builder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreDatabase>(
          create: (context) => databaseBuilder(context, UID),
        ),
      ],
      child: builder(context),
    );
  }
}
