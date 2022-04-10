import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../consts/global.dart';
import '../remote/app_dio.dart';
import 'notifications.dart';

void onSubmit({
  required BuildContext context,
  required ConfettiController confettiController,
  required int level,
  required String code,
}) async {
  try {
    final dio = Provider.of<AppDio>(context, listen: false);

    final response = await dio
        .post("/submit", data: {"uid": UID, "level": level, "code": code});

    if (response.statusCode == 201) {
      confettiController.play();

      successNotification(
          context: context,
          message: "Correct password! Congratulations!",
          toastGravity: ToastGravity.BOTTOM);

      return;
    }
  } catch (e) {
    failureNotification(
        context: context,
        message: "Inncorect password! Try again :D",
        toastGravity: ToastGravity.BOTTOM);
  }
}
