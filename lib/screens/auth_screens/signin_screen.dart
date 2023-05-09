import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/auth_widgets/signin_form.dart';
import 'sign_up_screen.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/doctor-sign-screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDoctor = ModalRoute.of(context)!.settings.arguments as bool;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mobileBackgroundColor,
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          leading: const BackIconButton(),
          centerTitle: true,
          title: SizedBox(
            // backgroundImage: AssetImage('assets/logo.png'),
            child: Image.asset('assets/logo.png', fit: BoxFit.contain),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Welcome to Afrad !',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    'Su currículo impresiona. Licenciado en Medicina por la Universidad de Córdoba (España), su trabajo de fin de carrera. Licenciado en .',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, height: 1.6),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  isDoctor ? 'Sign in as Doctor' : 'Sign in as Patient',
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SignInForm(),
                isDoctor
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text("Don't have an account?"),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName, arguments: isDoctor);
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: secondaryColor),
                              ),
                            ),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
