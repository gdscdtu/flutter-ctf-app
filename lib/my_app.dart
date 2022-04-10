import 'package:flutter/material.dart';
import 'package:flutter_ctf_app/auth_widget_builder.dart';
import 'package:flutter_ctf_app/services/firestore_database.dart';
import 'package:flutter_ctf_app/ui/home.dart';
import 'package:flutter_ctf_app/ui/welcome_screen.dart';

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
      builder: (BuildContext context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomeScreen(),
        );
      },
      key: const Key('AuthWidget'),
    );
  }
}
