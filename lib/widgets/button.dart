import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressHandler;

  const Button(this.color, this.text, this.onPressHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30)),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: color,
          ),
          onPressed: () {
            onPressHandler();
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
