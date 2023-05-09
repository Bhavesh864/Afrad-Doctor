// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../patient_screens/report_image_overviewscreen.dart';
import 'profile_screen.dart';
import 'package:afrad_doctor/widgets/profile_tabs.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';
import 'package:afrad_doctor/screens/app_screens/welcome_screen.dart';
import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/utils/colors.dart';

class UserAccountScreen extends StatefulWidget {
  static const routeName = '/loggedin-screen';
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  void logOutHandler() {
    showDialog(
      context: context,
      builder: ((ctx) {
        return AlertDialog(
          backgroundColor: activitiesBackgroundColor,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          icon: Image.asset(
            'assets/icons/logout.png',
            height: 60,
          ),
          title: const Text('Are you sure! You want to logout from this system'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: activitiesBackgroundColor,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 100,
                child: const Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(ctx).pop();

                final result = await Provider.of<Auth>(context, listen: false).logOut();

                if (result == 'Logout successfully') {
                  ShowMessages.showSnackBarMessage(result, context);
                  Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
                } else {
                  ShowMessages.showErrorDialog(result, context);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 100,
                child: const Text(
                  'Yes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final userData = authData.userData;
    final gender = userData['user_profile']['gender'];
    final type = userData['type'];
    final image = userData['image'];

    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: 420,
                  height: 250,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: activitiesBackgroundColor,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        image != null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: ((context) => ReportImageOverviewScreen('http://168.235.81.206:7100/$image')),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor, width: 3),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage("http://168.235.81.206:7100/$image"),
                                  ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${userData['first_name']} ${userData['last_name']}",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          userData['email'] ?? '',
                          style: const TextStyle(fontSize: 12, letterSpacing: 0.8),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ProfileTabs('Profile', () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                }),
                const SizedBox(
                  height: 20,
                ),
                ProfileTabs('My Schedules', () {}),
                const SizedBox(
                  height: 20,
                ),
                ProfileTabs(type == "doctor" ? 'Patients' : 'Doctors', () {}),
                const SizedBox(
                  height: 20,
                ),
                ProfileTabs('Messages', () {}),
                const SizedBox(
                  height: 20,
                ),
                ProfileTabs('Notifications', () {}),
                const SizedBox(
                  height: 20,
                ),
                ProfileTabs('Language', () {}),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        backgroundColor: const Color.fromARGB(255, 207, 64, 54),
                      ),
                      onPressed: logOutHandler,
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
