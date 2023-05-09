import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ShowMessages {
  static void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: ((ctx) {
        return AlertDialog(
          backgroundColor: activitiesBackgroundColor,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('An Error Occured!'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: TextStyle(color: secondaryColor),
                ))
          ],
        );
      }),
    );
  }

  static void showSnackBarMessage(String res, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          res,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: snackBarColor,
      ),
    );
  }
}
