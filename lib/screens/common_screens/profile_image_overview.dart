import 'package:afrad_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class ReportImageOverviewScreen extends StatelessWidget {
  final String imageSrc;
  const ReportImageOverviewScreen(this.imageSrc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Hero(
          tag: 'tag',
          child: Image.network(
            imageSrc,
            fit: BoxFit.contain,
            height: 600,
          ),
        ),
      ),
    );
  }
}
