import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 50,
              // ),
              SizedBox(
                child: Image.asset('assets/logo.png'),
              ),
              SizedBox(
                child: Image.asset('assets/afrad_bg.png'),
              ),
              SizedBox(
                child: Image.asset('assets/afrad.png'),
              ),

              // Stack(
              //   clipBehavior: Clip.none,
              //   children: const [
              //     Positioned(
              //       right: 10,
              //       bottom: 50,
              //       child: Text(
              //         'mics',
              //         style: TextStyle(fontSize: 25),
              //       ),
              //     ),
              //     Text(
              //       'AFRAD',
              //       style: TextStyle(fontSize: 50, letterSpacing: 7, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 50,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
