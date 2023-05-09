import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signin_screen.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';
import '../../providers/auth.dart';

class ChangePassWordScreen extends StatefulWidget {
  static const routeName = '/change-password';
  const ChangePassWordScreen({super.key});

  @override
  State<ChangePassWordScreen> createState() => _ChangePassWordScreenState();
}

class _ChangePassWordScreenState extends State<ChangePassWordScreen> {
  String? email;
  bool? isDoctor;
  @override
  void didChangeDependencies() {
    final userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = userData['email'];
    isDoctor = userData['isDoctor'];
    super.didChangeDependencies();
  }

  final newPassController = TextEditingController();
  final confirmNewPassController = TextEditingController();
  bool passwordText = true;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final GlobalKey<FormState> formKey = GlobalKey();

    void showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: ((ctx) {
          return AlertDialog(
            title: const Text('An Error Occured!'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'))
            ],
          );
        }),
      );
    }

    void showSnackBarMessage(String res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            res,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          backgroundColor: snackBarColor,
        ),
      );
      Navigator.of(context).pushReplacementNamed(SignInScreen.routeName, arguments: isDoctor);
    }

    void submitResetPasswordHandler() async {
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (newPassController.text == confirmNewPassController.text) {
        final result = await authData.changePassword(email!, newPassController.text, isDoctor! ? 'doctor' : 'patient');
        if (result == 'Password change successfully') {
          showSnackBarMessage(result);
        } else {
          showErrorDialog(result);
        }
      } else {
        showErrorDialog('Both password must be same!');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Your Password'),
        centerTitle: true,
        backgroundColor: mobileBackgroundColor,
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
                    padding: EdgeInsets.only(left: 20, bottom: 15),
                    child: Text('New Password'),
                  ),
                  TextFormField(
                    obscureText: passwordText,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be 6 digit long!';
                      }
                      return null;
                    },
                    controller: newPassController,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordText = !passwordText;
                          });
                        },
                        icon: Icon(passwordText ? Icons.visibility_off : Icons.visibility),
                      ),
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
                      hintText: 'New Password',
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 15),
                    child: Text('Confirm Password'),
                  ),
                  TextFormField(
                    obscureText: passwordText,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be 6 digit long!';
                      }
                      return null;
                    },
                    controller: confirmNewPassController,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordText = !passwordText;
                          });
                        },
                        icon: Icon(passwordText ? Icons.visibility_off : Icons.visibility),
                      ),
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
                      hintText: 'Confirm Password',
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
        child: Button(primaryColor, 'Submit', submitResetPasswordHandler),
      ),
    );
  }
}
