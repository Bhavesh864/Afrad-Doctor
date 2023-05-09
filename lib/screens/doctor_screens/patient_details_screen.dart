import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/doctor_flow_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/snackbars_dialogbox.dart';
import 'package:afrad_doctor/screens/doctor_screens/add_treatment_screen.dart';
import 'package:afrad_doctor/screens/common_screens/schedule_screen.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/widgets/button.dart';

class PatientDetailsScreen extends StatefulWidget {
  static const routeName = '/patient-detail-screen';
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => PatientDetailsScreenState();
}

class PatientDetailsScreenState extends State<PatientDetailsScreen> {
  var year = DateTime.now().year.toString();
  var month = DateFormat('MM').format(DateTime.now());

  List<String> infoTabsList = [
    'About',
    'Symptoms',
  ];
  List<String> selectedTabList = [];
  String selectedTab = 'About';

  void rescheduleHandler(int bookingId) {
    showDialog(
        context: context,
        builder: ((ctx) {
          return AlertDialog(
            backgroundColor: activitiesBackgroundColor,
            title: const Text('Do you want to Re-schedule ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: secondaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final authData = Provider.of<Auth>(context, listen: false);
                  Navigator.of(ctx).pop();

                  final result = await Provider.of<DoctorSchedules>(context, listen: false).applyReshcedule(
                    authData.accessToken!,
                    [bookingId],
                  );

                  if (result == 'Re-schedule apply successfully') {
                    showDialog(
                        context: context,
                        builder: ((ctx) {
                          return AlertDialog(
                            title: const Text('Your request for re-schedule has been subitted successfully'),
                            actions: [
                              Button(primaryColor, 'View Bookings', () {
                                Navigator.of(context).pushReplacementNamed(ScheduleScreen.routeName);
                              })
                            ],
                          );
                        }));
                  } else {
                    // ignore: use_build_context_synchronously
                    ShowMessages.showErrorDialog(result, context);
                  }
                },
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: secondaryColor,
                  ),
                ),
              ),
            ],
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    final patientData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final authData = Provider.of<Auth>(context, listen: false);
    // final slotData = Provider.of<Bookings>(context, listen: false);
    // final docData = Provider.of<DoctorSchedules>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          leading: const BackIconButton(),
          backgroundColor: mobileBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: patientData['gender'] == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${patientData["firstName"]} ${patientData['lastName']}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  patientData['email']!,
                  style: const TextStyle(fontSize: 12, letterSpacing: 0.8),
                ),
                const SizedBox(
                  height: 20,
                ),
                patientData['status'] == 'accepted'
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(activitiesBackgroundColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: borderColor),
                                ),
                              )),
                          onPressed: () {
                            rescheduleHandler(patientData['bookingId']);
                          },
                          child: const Text('Request a Re-schedule'),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Bookings Schedules',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: darkPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      patientData['day']!,
                      style: const TextStyle(height: 2),
                    ),
                    subtitle: Text(
                      '${patientData['startTime']} - ${patientData['endTime']}',
                      style: const TextStyle(height: 2),
                    ),
                    trailing: Text(
                      'Status: ${patientData['status']}',
                      style: TextStyle(
                        color: patientData['status'] == 'pending' || patientData['status'] == 're_schedule_pending'
                            ? Colors.yellow
                            : patientData['status'] == 'cancel'
                                ? Colors.red
                                : patientData['status'] == 'reject'
                                    ? Colors.white
                                    : Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Bookings Information',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  width: 370,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: infoTabsList.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedTab = infoTabsList[index];
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: selectedTab == infoTabsList[index] ? primaryColor : activitiesBackgroundColor,
                            ),
                            child: Text(
                              infoTabsList[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      })),
                ),
                const SizedBox(
                  height: 20,
                ),
                selectedTab == 'About'
                    ? Column(
                        children: [
                          ListTile(
                            isThreeLine: true,
                            title: const Text('About Me'),
                            subtitle: Text('${patientData['about']}'),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: const Text('Address', style: TextStyle(height: 2)),
                            subtitle: Text(patientData['address']!),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: patientData['status'] == 'accepted' && DateTime.parse(patientData['bookingDate']).isBefore(DateTime.now())
            ? Container(
                margin: const EdgeInsets.all(10),
                child: Button(
                  primaryColor,
                  'Complete Bookings',
                  () {
                    Navigator.of(context).pushNamed(AddTreatmentScreen.routeName, arguments: patientData['bookingId']);
                  },
                ),
              )
            : null);
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> indexedMap<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }
}
