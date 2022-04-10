import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../consts/my_colors.dart';

void successNotification(
    {required BuildContext context,
    required String message,
    ToastGravity? toastGravity}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: toastGravity ?? ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: MyColors.jungleGreen,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void failureNotification(
    {required BuildContext context,
    required String message,
    ToastGravity? toastGravity}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: toastGravity ?? ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: MyColors.cinnabar,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
