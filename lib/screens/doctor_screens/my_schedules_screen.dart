import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/utils/colors.dart';
import '../../providers/auth.dart';
import '../../providers/doctor_flow_provider.dart';
import '../../widgets/snackbars_dialogbox.dart';
import 'package:afrad_doctor/models/doctor_models/all_booking_list.dart';
import 'package:afrad_doctor/screens/doctor_screens/patient_details_screen.dart';

class DoctorSchedulesScreen extends StatefulWidget {
  static const routeName = '/my-schedule';
  const DoctorSchedulesScreen({super.key});

  @override
  State<DoctorSchedulesScreen> createState() => _DoctorSchedulesScreenState();
}

class _DoctorSchedulesScreenState extends State<DoctorSchedulesScreen> {
  List<String> tabsName = ['All Schedules', 'Re-schedule', 'Accepted', 'Pending', 'Completed'];
  var currentSelectedTab = 'All Schedules';
  String requestedStatus = 'all';
  List<String> requestedStatusList = ['all', 'Re_Schedule', 'accepted', 'pending', 'completed'];
  // ignore: prefer_typing_uninitialized_variables
  var selectedDate;
  var isSelected = true;

  void patientDetailsTap(
    String gender,
    String firstName,
    String lastName,
    String email,
    String day,
    String startTime,
    String endTime,
    String about,
    String address,
    String status,
    String reason,
    int bookingId,
    String bookingDate,
  ) {
    if (status == 'cancel' || status == 'accepted' || status == 'completed') {
      Navigator.of(context).pushNamed(PatientDetailsScreen.routeName, arguments: {
        'gender': gender,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'day': day,
        'startTime': startTime,
        'endTime': endTime,
        'about': about,
        'address': address,
        'status': status,
        'bookingId': bookingId,
        'bookingDate': bookingDate,
      });
    } else if (status == 'reject') {
      ShowMessages.showSnackBarMessage(reason, context);
    } else if (status == 'pending' || status == 're_schedule_pending') {
      ShowMessages.showSnackBarMessage('Your booking status is pending. No Doctor is Assigned To You', context);
    } else {
      ShowMessages.showSnackBarMessage('Something went wrong!', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final docData = Provider.of<DoctorSchedules>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text('My Schedules'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            showHorizontalTabs(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Search Schedules',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((context) {
                          return Container(
                            height: 300,
                            padding: const EdgeInsets.all(10),
                            color: const Color.fromARGB(255, 12, 24, 34),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  'Filter By',
                                  style: TextStyle(fontSize: 20),
                                ),
                                TextButton(
                                    onPressed: () {
                                      isSelected = !isSelected;
                                      Navigator.of(context).pop();
                                      selectedDate = DateTime.now();
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Today',
                                      style: TextStyle(fontSize: 15, color: isSelected ? secondaryColor : Colors.white),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      isSelected = !isSelected;
                                      Navigator.of(context).pop();
                                      selectedDate = DateTime.now().add(const Duration(days: 1));
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Tommorrow',
                                      style: TextStyle(fontSize: 15, color: isSelected ? Colors.white : secondaryColor),
                                    )),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate ?? DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2024),
                                    );
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'Pick Date',
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     SizedBox(
                                //       width: 150,
                                //       height: 45,
                                //       child: ElevatedButton(
                                //         style: ButtonStyle(
                                //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                //             RoundedRectangleBorder(
                                //               borderRadius: BorderRadius.circular(18.0),
                                //               side: const BorderSide(color: Colors.white),
                                //             ),
                                //           ),
                                //           backgroundColor: MaterialStateProperty.all(primaryColor),
                                //         ),
                                //         onPressed: () {},
                                //         child: const Text('Apply'),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 150,
                                //       height: 45,
                                //       child: ElevatedButton(
                                //         style: ButtonStyle(
                                //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                //             RoundedRectangleBorder(
                                //               borderRadius: BorderRadius.circular(18.0),
                                //               side: BorderSide(color: Colors.white),
                                //             ),
                                //           ),
                                //           backgroundColor: MaterialStateProperty.all(Colors.red),
                                //         ),
                                //         onPressed: () {
                                //           Navigator.of(context).pop();
                                //         },
                                //         child: const Text('Cancel'),
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          );
                        }));
                  },
                  icon: const Icon(Icons.tune),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Showing the result of ${DateFormat("dd-MM-yyyy").format(selectedDate ?? DateTime.now())} Schedules',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<AllBookingList>(
                future: docData.allBookingsOfDoctor(int.parse(authData.userId!), selectedDate ?? DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now())), authData.accessToken!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  } else {
                    if (snapshot.data!.status == false || snapshot.data!.data!.isEmpty) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Your Today\'s Schedules',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          const Icon(
                            Icons.event_busy,
                            size: 70,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'No Schedules for today !',
                            style: TextStyle(fontSize: 22),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, i) {
                            final bookingData = snapshot.data!.data![i];
                            final patientData = bookingData.patient;
                            final userProfile = patientData!.userProfile;
                            if (currentSelectedTab == 'Re-schedule' && bookingData.status != 're_schedule_pending') {
                              return Container();
                            } else if (currentSelectedTab == 'Accepted' && bookingData.status != 'accepted') {
                              return Container();
                            } else if (currentSelectedTab == 'Pending' && bookingData.status != 'pending') {
                              return Container();
                            } else if (currentSelectedTab == 'Completed' && bookingData.status != 'completed') {
                              return Container();
                            }
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: scheduleDays,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    isThreeLine: true,
                                    leading: CircleAvatar(
                                      radius: 30,
                                      foregroundImage: userProfile!.gender == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                                    ),
                                    title: Text(
                                      '${patientData.firstName} ${patientData.lastName}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    subtitle: RichText(
                                      text: TextSpan(
                                        text:
                                            'Booking Time: ${DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.startTime!))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.endTime!))} \n',
                                        style: const TextStyle(fontSize: 12, height: 1.5),
                                        children: [
                                          TextSpan(
                                            text: 'Booking Date: ${DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(bookingData.createdAt!))}  \n  ',
                                            style: const TextStyle(height: 1, fontSize: 12),
                                          ),
                                          TextSpan(
                                            text: bookingData.status,
                                            style: TextStyle(
                                              color: bookingData.status == 'pending' || bookingData.status == 're_schedule_pending'
                                                  ? Colors.yellow
                                                  : bookingData.status == 'cancel'
                                                      ? Colors.red
                                                      : bookingData.status == 'reject'
                                                          ? Colors.white
                                                          : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      patientDetailsTap(
                                        userProfile.gender!,
                                        patientData.firstName!,
                                        patientData.lastName!,
                                        patientData.email!,
                                        ' ${DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(patientData.createdAt!))}',
                                        DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.startTime!)),
                                        DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.endTime!)),
                                        userProfile.about ?? 'About',
                                        userProfile.address ?? 'Address',
                                        bookingData.status!,
                                        bookingData.reason ?? 'No reason',
                                        bookingData.id!,
                                        bookingData.createdAt!,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  // Widget schedulesListTiles(patientData, userProfile, bookingData) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 20),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       color: scheduleDays,
  //     ),
  //     child: Column(
  //       children: [
  //         ListTile(
  //           isThreeLine: true,
  //           leading: CircleAvatar(
  //             radius: 30,
  //             foregroundImage: userProfile!.gender == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
  //           ),
  //           title: Text(
  //             '${patientData.firstName} ${patientData.lastName}',
  //             style: const TextStyle(fontSize: 18),
  //           ),
  //           subtitle: RichText(
  //             text: TextSpan(
  //               text: 'Booking Time: ${DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.startTime!))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.endTime!))} \n',
  //               style: const TextStyle(fontSize: 12, height: 1.5),
  //               children: [
  //                 TextSpan(
  //                   text: 'Booking Date: ${DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(bookingData.createdAt!))}  \n  ',
  //                   style: const TextStyle(height: 1, fontSize: 12),
  //                 ),
  //                 TextSpan(
  //                   text: bookingData.status,
  //                   style: TextStyle(
  //                     color: bookingData.status == 'pending'
  //                         ? Colors.yellow
  //                         : bookingData.status == 'cancel'
  //                             ? Colors.red
  //                             : bookingData.status == 'reject'
  //                                 ? Colors.white
  //                                 : Colors.green,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           trailing: const Icon(Icons.arrow_forward_ios),
  //           onTap: () {
  //             patientDetailsTap(
  //               userProfile.gender!,
  //               patientData.firstName!,
  //               patientData.lastName!,
  //               patientData.email!,
  //               ' ${DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(patientData.createdAt!))}',
  //               DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.startTime!)),
  //               DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData.endTime!)),
  //               userProfile.about ?? 'About',
  //               userProfile.address ?? 'Address',
  //               bookingData.status!,
  //               bookingData.reason ?? 'No reason',
  //               bookingData,
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget showHorizontalTabs() {
    return Container(
      height: 35,
      margin: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tabsName.length,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: OutlinedButton(
              onPressed: (() {
                setState(() {
                  currentSelectedTab = tabsName[index];
                  requestedStatus = requestedStatusList[index];
                });
              }),
              style: OutlinedButton.styleFrom(
                backgroundColor: currentSelectedTab == tabsName[index] ? primaryColor : activitiesBackgroundColor,
              ),
              child: Text(
                tabsName[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }),
      ),
    );
  }
}
