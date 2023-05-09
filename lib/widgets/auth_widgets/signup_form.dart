// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../screens/auth_screens/signin_screen.dart';
import '../../providers/auth.dart';
import '../../utils/colors.dart';
import '../male_female.dart';
import '../button.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalityController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var isYourGender;
  bool isLoading = false;

  void signUpHandler() async {
    FocusScope.of(context).unfocus();
    final authData = Provider.of<Auth>(context, listen: false);
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (isYourGender == null) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final result = await authData.signUp(
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      passwordController.text,
      isYourGender,
      phoneController.text,
      nationalityController.text,
    );
    setState(() {
      isLoading = false;
    });
    if (result == 'Register successfully') {
      ShowMessages.showSnackBarMessage('$result ! Register Successfully!  Verification sent to your gmail please verify you account!', context);
      Navigator.of(context).pushReplacementNamed(SignInScreen.routeName, arguments: false);
    } else {
      ShowMessages.showErrorDialog(result, context);
    }
  }

  Widget inputFieldTitle(String title) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(title),
        ),
      ],
    );
  }

  void whatIsGender(String gender) {
    isYourGender = gender;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputFieldTitle('First Name'),
          TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value!.isEmpty || value.length < 3) {
                return 'First Name Required!';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.sentences,
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
              hintText: 'First Name',
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          inputFieldTitle('Last Name'),
          TextFormField(
            controller: lastNameController,
            validator: (value) {
              if (value!.isEmpty || value.length < 3) {
                return 'Last Name Required!';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.sentences,
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
              hintText: 'Last Name',
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          inputFieldTitle('Email'),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email Required!';
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
              hintText: 'Email',
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          inputFieldTitle('Password'),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty || value.contains('@') || value.contains('.com')) {
                return 'Password Required!';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
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
          inputFieldTitle('Mobile Number'),
          TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            controller: phoneController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Contact Number Required!';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
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
              hintText: 'Contact Number',
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          inputFieldTitle('Nationality'),
          TextFormField(
            controller: nationalityController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nationality Required!';
              }
              return null;
            },
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
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
              hintText: 'Nationality',
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          inputFieldTitle('Gender'),
          MaleFemaleButton(whatIsGender),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text("Already have an account?"),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(SignInScreen.routeName, arguments: false);
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: secondaryColor),
                  ),
                ),
              ),
            ],
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Button(primaryColor, 'Sign up', signUpHandler),
        ],
      ),
    );
  }
}
