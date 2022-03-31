import 'package:confetti/confetti.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_ctf_app/ui/background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../consts/my_colors.dart';
import '../../consts/my_icons.dart';
import '../../helper/notifications.dart';
import '../../services/firestore_database.dart';
import '../unlocked_level_screen.dart';

class Level5Screen extends StatefulWidget {
  const Level5Screen({Key? key, required this.level})
      : assert(level == 5),
        super(key: key);

  final int level;
  @override
  State<Level5Screen> createState() => _Level5ScreenState();
}

class _Level5ScreenState extends State<Level5Screen> {
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(MyIcons.keys),
                    Text(
                      "Level ${widget.level}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _passwordController.value = TextEditingValue(
                          text: value.toLowerCase(),
                          selection: _passwordController.selection,
                        );
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // enabled: false,
                      ),
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        primary: MyColors.tropicalBlue,
                        shadowColor: Colors.transparent.withOpacity(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        _onSubmit(context);
                      },
                      child: const Text(
                        'Kiểm tra',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(MyIcons.lockedLock),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyColors.cornflowerBlue22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "password: ctf-gdsc-dtu",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConfettiWidget(
                confettiController: _controllerBottomCenter,
                blastDirection: -pi / 2,
                emissionFrequency: 0.01,
                numberOfParticles: 20,
                maxBlastForce: 100,
                minBlastForce: 80,
                gravity: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context) async {
    if (_passwordController.text.toString() == "ctf-gdsc-dtu") {
      final firestoreDatabase =
          Provider.of<FirestoreDatabase>(context, listen: false);

      successNotification(
        message: "Correct password! Congratulations!",
        toastGravity: ToastGravity.BOTTOM,
      );

      _controllerBottomCenter.play();

      await Future.delayed(
        const Duration(seconds: 4),
        () async {
          firestoreDatabase.updateLevel(level: widget.level + 1);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  UnlockedLevelScreen(level: widget.level + 1),
            ),
          );
        },
      );
      return;
    }

    failureNotification(
      message: "Inncorect password! Try again :D",
      toastGravity: ToastGravity.BOTTOM,
    );
  }
}
