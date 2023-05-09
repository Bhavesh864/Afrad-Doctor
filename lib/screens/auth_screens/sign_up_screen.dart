import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/auth_widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Great let\'s get started',
                    style: TextStyle(color: secondaryColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Create Your Account !',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SignUpForm(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          const TextSpan(text: "By signing up you're agree to our "),
                          TextSpan(
                            text: " Terms & Conditions Privacy & Policies ",
                            style: TextStyle(color: secondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
