// ignore_for_file: use_build_context_synchronously

import 'package:afrad_doctor/screens/auth_screens/change_password_screen.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import 'package:afrad_doctor/utils/colors.dart';
import 'package:flutter/services.dart';
import '../../widgets/button.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp-screen';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? email;
  bool? isDoctor;
  final controllerOne = TextEditingController();
  final controllerTwo = TextEditingController();
  final controllerThree = TextEditingController();
  final controllerFour = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void didChangeDependencies() {
    final userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = userData['email'];
    isDoctor = userData['isDoctor'];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);

    void otpVerifyHandler() {
      if (!formKey.currentState!.validate()) {
        return;
      }

      final enteredOtp = '${controllerOne.text}${controllerTwo.text}${controllerThree.text}${controllerFour.text}';
      final serverOtp = authData.otp;

      if (serverOtp == enteredOtp) {
        ShowMessages.showSnackBarMessage('OTP Checked Successfully!', context);
        Navigator.of(context).pushNamed(ChangePassWordScreen.routeName, arguments: {'email': email, 'isDoctor': isDoctor});
      } else {
        ShowMessages.showErrorDialog('Invalid OTP', context);
      }
    }

    void resendOTP() async {
      final result = await authData.forgotPassword(email!, isDoctor! ? 'doctor' : 'patient');

      if (result == 'Otp for the user') {
        ShowMessages.showSnackBarMessage('OTP resend successfully!', context);
      } else {
        ShowMessages.showErrorDialog(result, context);
      }
    }

    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: 600,
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Enter OTP',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'We have sent an OTP on you registered Email id $email ',
                  style: const TextStyle(height: 1.8, fontSize: 16),
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controllerOne,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'OTP';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorStyle: TextStyle(color: primaryColor),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          hintText: '0',
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: controllerTwo,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorStyle: TextStyle(color: primaryColor),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          hintText: '0',
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: controllerThree,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorStyle: TextStyle(color: primaryColor),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          hintText: '0',
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: controllerFour,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorStyle: TextStyle(color: primaryColor),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          hintText: '0',
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: resendOTP,
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Text(
                      '00:00',
                      style: TextStyle(color: secondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            width: 350,
            alignment: Alignment.bottomRight,
            child: Button(primaryColor, 'Verify', otpVerifyHandler),
          ),
        ),
      ),
    );
  }
}
