import 'package:flutter/material.dart';
import 'package:flutter_ctf_app/auth_widget_builder.dart';
import 'package:flutter_ctf_app/provider/auth_provider.dart';
import 'package:flutter_ctf_app/services/firestore_database.dart';
import 'package:flutter_ctf_app/ui/auth/login_screen.dart';
import 'package:flutter_ctf_app/ui/home.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({required Key key, required this.databaseBuilder})
      : super(key: key);

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthWidgetBuilder(
      databaseBuilder: databaseBuilder,
      builder: (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
        return MaterialApp(
          home: Consumer<AuthProvider>(builder: (_, authProvider, __) {
            if (userSnapshot.connectionState == ConnectionState.active) {
              return userSnapshot.hasData && userSnapshot.data?.uid != "null"
                  ? const HomeScreen()
                  : const LoginScreen();
            }
            return const Material(
              child: Center(child: CircularProgressIndicator()),
            );
          }),
        );
      },
      key: const Key('AuthWidget'),
    );
  }
}
