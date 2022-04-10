import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(BuildContext context, String password) {
  Clipboard.setData(ClipboardData(text: password)).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password copied to clipboard")));
  });
}
