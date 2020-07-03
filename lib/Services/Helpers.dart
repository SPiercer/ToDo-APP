import 'package:flutter/material.dart';

class Helpers {
  static Future<void> showMyDialog({BuildContext context, String msg}) =>
      showDialog(
          context: context,
          child: AlertDialog(
            title: Center(child: Text(msg, textAlign: TextAlign.center)),
          ));
}
