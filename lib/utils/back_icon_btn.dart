import 'package:afrad_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      alignment: Alignment.topCenter,
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: CircleAvatar(
        backgroundColor: primaryColor,
        radius: 15,
        child: const Icon(
          Icons.arrow_back_ios_new_sharp,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
