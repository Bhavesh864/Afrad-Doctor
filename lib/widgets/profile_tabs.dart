import 'package:flutter/material.dart';

import 'package:afrad_doctor/utils/colors.dart';

class ProfileTabs extends StatelessWidget {
  final String text;
  final Function tabHandler;
  const ProfileTabs(this.text, this.tabHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            backgroundColor: activitiesBackgroundColor,
          ),
          onPressed: () {
            tabHandler();
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
