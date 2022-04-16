import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../consts/global.dart';
import '../models/user_model.dart';
import '../remote/app_dio.dart';
import 'notifications.dart';

void onSubmit({
  required BuildContext context,
  required ConfettiController confettiController,
  required UserModel user,
  required String code,
}) async {
  try {
    final dio = Provider.of<AppDio>(context, listen: false);
    print("code: $code");
    final response = await dio
        .post("/submit", data: {"uid": UID, "level": user.level, "code": code});
    print("response: $response");
    if (response.statusCode == 201) {
      confettiController.play();

      successNotification(
          context: context,
          message: "Correct password! Congratulations!",
          toastGravity: ToastGravity.BOTTOM);

      return;
    }
  } catch (e) {
    print("Error: $e");
    if (e is DioError) {
      if (e.response?.data["message"][0] == "Level is wrong") {
        failureNotification(
          context: context,
          message: "Your are treating! Warning 1!",
          toastGravity: ToastGravity.BOTTOM,
        );
        return;
      }
      if (user.isBlocked!) {
        failureNotification(
          context: context,
          message: "Your are blocked because of treating!",
          toastGravity: ToastGravity.BOTTOM,
        );

        return;
      }
      failureNotification(
        context: context,
        message: "Inncorect password! Try again :D",
        toastGravity: ToastGravity.BOTTOM,
      );
    }
  }
}
