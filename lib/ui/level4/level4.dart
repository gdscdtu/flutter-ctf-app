import 'dart:math';

import 'package:confetti/confetti.dart';
import "package:flutter/material.dart";
import 'package:flutter_ctf_app/ui/background.dart';

import '../../consts/my_colors.dart';
import '../../consts/my_icons.dart';
import '../../helper/copy_to_clipboard.dart';
import '../../helper/on_submit.dart';
import '../../models/user_model.dart';

class Level4Screen extends StatefulWidget {
  Level4Screen({Key? key, required this.user})
      : assert(user.level == 4),
        super(key: key);

  final UserModel user;
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
                      "Level ${widget.user.level}",
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
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'V???ng ??i m??? ra',
                        suffixIcon: IconButton(
                          onPressed: _passwordController.clear,
                          icon: const Icon(Icons.clear),
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
                        onSubmit(
                          context: context,
                          confettiController: _controllerBottomCenter,
                          user: widget.user,
                          code: _passwordController.text.toString(),
                        );
                      },
                      child: const Text(
                        'Ki???m tra',
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
                        "KnifeGladThoroughSilent1",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        color: MyColors.silver,
                        onPressed: () {
                          copyToClipboard(context, "KnifeGladThoroughSilent1");
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
}
