import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../auth_screens/signin_screen.dart';
import '../../widgets/button.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void doctorHandler() {
    Navigator.of(context).pushNamed(
      SignInScreen.routeName,
      arguments: true,
    );
  }

  void patientHandler() {
    Navigator.of(context).pushNamed(
      SignInScreen.routeName,
      arguments: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  scale: 1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Welcome to Afrad!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Su currículo impresiona. Licenciado en Medicina por la Universidad de Córdoba (España), su trabajo de fin de carrera. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, height: 1.6),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text('Define about yourself ?'),
              const SizedBox(
                height: 30,
              ),
              Button(secondaryColor, 'Doctor', doctorHandler),
              const SizedBox(
                height: 50,
              ),
              Button(primaryColor, 'Patient', patientHandler),
            ],
          ),
        ),
      ),
    );
  }
}
