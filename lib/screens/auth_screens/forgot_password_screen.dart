// ignore_for_file: use_build_context_synchronously

import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/screens/auth_screens/otp_screen.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';
import '../../utils/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-pass-screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDoctor = ModalRoute.of(context)!.settings.arguments as bool;
    final authData = Provider.of<Auth>(context, listen: false);

    void sendEmailHandler() async {
      if (!formKey.currentState!.validate()) {
        return;
      }

      final result = await authData.forgotPassword(emailController.text, isDoctor ? 'doctor' : 'patient');

      if (result == 'Otp for the user') {
        ShowMessages.showSnackBarMessage('OTP sent successfully!', context);

        Navigator.of(context).pushNamed(
          OtpScreen.routeName,
          arguments: {
            'email': emailController.text,
            'isDoctor': isDoctor,
          },
        );
      } else {
        ShowMessages.showErrorDialog(result, context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        leading: const BackIconButton(),
        centerTitle: true,
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 20),
                    child: Text('Email'),
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@') || !value.contains('.com')) {
                        return 'Valid Email Required !';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
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
                      hintText: 'Enter your Email address',
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 350,
        alignment: Alignment.bottomRight,
        child: Button(primaryColor, 'Send Email', sendEmailHandler),
      ),
    );
  }
}
