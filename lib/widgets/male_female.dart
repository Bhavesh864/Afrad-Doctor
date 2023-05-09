import 'package:flutter/material.dart';

import '../utils/colors.dart';

// ignore: must_be_immutable
class MaleFemaleButton extends StatefulWidget {
  void Function(String gender) isGender;

  MaleFemaleButton(this.isGender, {super.key});

  @override
  State<MaleFemaleButton> createState() => _MaleFemaleButtonState();
}

class _MaleFemaleButtonState extends State<MaleFemaleButton> {
  // ignore: avoid_init_to_null
  var _gender = null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 165,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: primaryColor,
              ),
              borderRadius: BorderRadius.circular(30)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: OutlinedButton(
              onPressed: () {
                _gender = 'Male';
                widget.isGender(_gender);
                setState(() {});
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                backgroundColor: _gender == 'Male' ? primaryColor : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/male.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Male',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: 165,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: primaryColor,
              ),
              borderRadius: BorderRadius.circular(30)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: OutlinedButton(
              onPressed: () {
                _gender = 'Female';
                widget.isGender(_gender);
                setState(() {});
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                backgroundColor: _gender == 'Female' ? primaryColor : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/female.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Female',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
