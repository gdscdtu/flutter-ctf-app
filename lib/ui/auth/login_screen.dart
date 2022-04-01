import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/gdg_logo.png",
                width: 200,
                height: 200,
              ),
              const Text(
                "Google Developer Student Clubs",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const Text(
                "Duy Tan University",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () async {
                    bool status = await authProvider.signInWithGoogle();

                    if (!status) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Error Sign In"),
                      ));
                    } else {
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/gg_icon.png",
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "LOGIN WITH GOOGLE",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
