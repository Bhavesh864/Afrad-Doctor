import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String imgText;
  final String text;
  const EmptyScreen(this.text, this.imgText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/patient/$imgText.png'),
          const SizedBox(
            height: 20,
          ),
          Text('No $text details updated yet !'),
        ],
      ),
    );
  }
}
