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

class Level4Screen extends StatefulWidget {
  const Level4Screen({Key? key, required this.level})
      : assert(level == 4),
        super(key: key);

  final int level;
  @override
  State<Level4Screen> createState() => _Level4ScreenState();
}

class _Level4ScreenState extends State<Level4Screen> {
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
                    child: TextFormField(
                      enabled: false,
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyColors.cornflowerBlue22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "GDSC-DTU-2022",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        color: MyColors.silver,
                        onPressed: () {
                          _copyToClipboard(context);
                        },
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
    if (_passwordController.text.toString() == "GDSC-DTU-2022") {
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

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: "GDSC-DTU-2022")).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password copied to clipboard")));
    });
  }
}
