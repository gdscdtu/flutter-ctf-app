import 'package:confetti/confetti.dart';
import "package:flutter/material.dart";
import 'dart:math';

import '../../consts/my_colors.dart';

class UnlockedLevelScreen extends StatefulWidget {
  const UnlockedLevelScreen({Key? key}) : super(key: key);

  @override
  State<UnlockedLevelScreen> createState() => _UnlockedLevelScreenState();
}

class _UnlockedLevelScreenState extends State<UnlockedLevelScreen> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
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
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: MyColors.hippieBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 280,
                  height: 280,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: MyColors.midNight,
                      borderRadius: BorderRadius.circular(31)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset("assets/images/Lock-open.png"),
                      Align(
                        alignment: Alignment.topCenter,
                        child: ConfettiWidget(
                          confettiController: _controllerCenter,
                          blastDirectionality: BlastDirectionality
                              .explosive, // don't specify a direction, blast randomly
                          shouldLoop:
                              true, // start again as soon as the animation is finished
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple
                          ], // manually specify the colors to be used
                          createParticlePath:
                              drawStar, // define a custom shape/path.
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          primary: MyColors.tropicalBlue,
                          shadowColor: Colors.transparent.withOpacity(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Level 2',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Image.asset("assets/images/Succes.png"),
            top: 120,
            left: -10,
          ),
          Positioned(
            child: Image.asset("assets/images/Succes-2.png"),
            bottom: 120,
            right: -10,
          ),
        ],
      ),
    );
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
