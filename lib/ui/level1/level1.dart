import 'package:confetti/confetti.dart';
import "package:flutter/material.dart";
import 'package:flutter_ctf_app/consts/my_icons.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../consts/my_colors.dart';
import '../../services/firestore_database.dart';

class Level1Screen extends StatefulWidget {
  const Level1Screen({Key? key}) : super(key: key);

  @override
  State<Level1Screen> createState() => _Level1ScreenState();
}

class _Level1ScreenState extends State<Level1Screen> {
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
    return Container(
      height: double.infinity,
      width: double.infinity,
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/ctf_background.png"),
          fit: BoxFit.cover,
        ),
      ),
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
                    const Text(
                      "Level 1",
                      style: TextStyle(
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
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // enabled: false,
                        hintText: 'Vừng ơi mở ra',
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
                        "xTbdasdbibwdiabs",
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
    if (_passwordController.text.toString() == "xTbdasdbibwdiabs") {
      final firestoreDatabase =
          Provider.of<FirestoreDatabase>(context, listen: false);

      Fluttertoast.showToast(
        msg: "Correct password! Congratulations!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.jungleGreen,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _controllerBottomCenter.play();

      await Future.delayed(const Duration(seconds: 4),
          () async => firestoreDatabase.updateLevel(level: 2));
      return;
    }

    Fluttertoast.showToast(
      msg: "Inncorect password! Try again :D",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: MyColors.cinnabar,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: "xTbdasdbibwdiabs")).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password copied to clipboard")));
    });
  }
}
