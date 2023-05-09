// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../screens/auth_screens/forgot_password_screen.dart';
import '../button.dart';
import '../../utils/colors.dart';
import 'package:afrad_doctor/screens/app_screens/tab_bar_screen.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final isDoctor = ModalRoute.of(context)!.settings.arguments as bool;

    void signInFunc() async {
      FocusScope.of(context).unfocus();
      if (!formKey.currentState!.validate()) {
        return;
      }

      setState(() {
        isLoading = true;
      });
      final result = await authData.logIn(
        emailController.text.toString(),
        passwordController.text,
        DateTime.now().toString(),
        isDoctor ? 'doctor' : 'patient',
        context,
      );
      setState(() {
        isLoading = false;
      });
      if (result == 'login successfully') {
        ShowMessages.showSnackBarMessage(result, context);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      } else {
        ShowMessages.showErrorDialog(result, context);
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text('Username/Email'),
          ),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@') || !value.contains('.com')) {
                return 'Valid Email Required !';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey.shade700),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              errorStyle: TextStyle(color: primaryColor),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: primaryColor),
              ),
              hintText: 'UserName/Email',
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text('Password'),
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Password Required !';
              }
              return null;
            },
            obscureText: true,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey.shade700),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              errorStyle: TextStyle(color: primaryColor),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: primaryColor),
              ),
              hintText: 'Password',
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName, arguments: isDoctor);
              },
              child: const Text(
                'Forgot Password ',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Button(
                  primaryColor,
                  'Sign in',
                  signInFunc,
                ),
        ],
      ),
    );
  }
}

//Doctor
// email : madhav@mailinator.com 
//pass : 123456

//Patient
//email : madhavsewag04@gmail.com
//pass : 123456
//email : harsh2@mailinator.com
//pass : 123456