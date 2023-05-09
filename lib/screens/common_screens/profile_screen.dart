// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:afrad_doctor/screens/app_screens/tab_bar_screen.dart';
import 'package:afrad_doctor/screens/common_screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  File? selectedImage;
  bool isGender = true;
  bool isLoading = false;

  var gender = 'Male';

  var firstName;
  var lastName;
  var age;
  var address;
  var nationality;
  var about;
  var image;

  void authProvider() {}

  void imagePicker() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: activitiesBackgroundColor,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Camera"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Gallery"),
            ),
          ],
        ),
      ),
    );

    if (isCamera == null) return;

    XFile? file = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (file != null) {
      selectedImage = File(file.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final docPatData = authData.userData;
    firstName = docPatData['first_name'] ?? '';
    lastName = docPatData['last_name'] ?? '';
    age = docPatData['user_profile']['age'].toString() == 'null' ? '' : docPatData['user_profile']['age'].toString();
    address = docPatData['user_profile']['address'] ?? '';
    nationality = docPatData['nationality'] ?? '';
    about = docPatData['user_profile']['about'] ?? '';
    image = docPatData['image'];
    if (isGender == true) {
      gender = docPatData['user_profile']['gender'];
    }

    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);
    final ageController = TextEditingController(text: age);
    final addressController = TextEditingController(text: address);
    final nationalityController = TextEditingController(text: nationality);
    final aboutController = TextEditingController(text: about);

    void saveChangesHandler() async {
      setState(() {
        isLoading = true;
      });
      final authData = Provider.of<Auth>(context, listen: false);

      // if (selectedImage == null) {
      //   showErrorDialog('Please provide an image!');
      //   return;
      // }

      if (!formKey.currentState!.validate()) {
        return;
      }

      FocusScope.of(context).unfocus();

      final result = await authData.editProfile(
        selectedImage,
        firstNameController.text,
        lastNameController.text,
        ageController.text,
        addressController.text,
        nationalityController.text,
        aboutController.text,
        gender,
      );

      setState(() {
        isLoading = false;
      });

      if (result == 'User profile updated') {
        ShowMessages.showSnackBarMessage('Your profile updated successfully!', context);
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      } else {
        ShowMessages.showErrorDialog(result, context);
      }
    }

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 20,
            alignment: Alignment.topCenter,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 15,
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: mobileBackgroundColor,
          title: const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: imagePicker,
                      child: Center(
                        child: selectedImage != null
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor, width: 3),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(selectedImage!),
                                ),
                              )
                            : image != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor, width: 3),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage("http://168.235.81.206:7100/$image"),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor, width: 3),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: gender == "Male" ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                                    ),
                                  ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      right: 150,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          child: IconButton(
                            onPressed: imagePicker,
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Text('First Name'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return 'First Name Required!';
                    }
                    return null;
                  },
                  controller: firstNameController,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Text('Last Name'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return 'Last Name Required!';
                    }
                    return null;
                  },
                  controller: lastNameController,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Text('Age'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Valid age required';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Text('Address'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Complete address Required!';
                    }
                    return null;
                  },
                  controller: addressController,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Text('Nationality'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nationality Required!';
                    }
                    return null;
                  },
                  controller: nationalityController,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Nationality',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Text('About Yourself'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please tell about yourself! !';
                    }
                    return null;
                  },
                  controller: aboutController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'About',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Text('Gender'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 165,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: OutlinedButton(
                          onPressed: () {
                            isGender = !isGender;
                            gender = 'Female';
                            setState(() {});
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            backgroundColor: gender == 'Female' ? primaryColor : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/female.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Female',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 165,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: OutlinedButton(
                          onPressed: () {
                            isGender = !isGender;
                            gender = 'Male';
                            setState(() {});
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            backgroundColor: gender == 'Male' ? primaryColor : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/male.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Male',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: 350,
          alignment: Alignment.bottomRight,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Button(primaryColor, 'Save', saveChangesHandler),
        ),
      ),
    );
  }
}
