import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/doctor_models/doctor_schedule_list_by_id.dart';
import '../../providers/auth.dart';
import '../../providers/doctor_flow_provider.dart';
import '../../screens/doctor_screens/patient_details_screen.dart';
import '../../utils/colors.dart';
import 'package:afrad_doctor/widgets/doctor_widgets/check_box.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';

class DoctorSchedulesListTiles extends StatefulWidget {
  final DateTime pickedDate;
  final String currentSelectedTab;
  final Function sendBookingList;
  const DoctorSchedulesListTiles(this.pickedDate, this.currentSelectedTab, this.sendBookingList, {super.key});

  @override
  State<DoctorSchedulesListTiles> createState() => _DoctorSchedulesListTilesState();
}

class _DoctorSchedulesListTilesState extends State<DoctorSchedulesListTiles> {
  List<int> selectedBookingIdList = [];

  void setBookingId(int bookingId) {
    if (selectedBookingIdList.contains(bookingId)) {
      selectedBookingIdList.remove(bookingId);
    } else {
      selectedBookingIdList.add(bookingId);
    }
    widget.sendBookingList(selectedBookingIdList);
  }

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
    final authData = Provider.of<Auth>(context, listen: false);
    final docData = Provider.of<DoctorSchedules>(context, listen: false);

    return FutureBuilder<DoctorScheduleListById>(
        future: docData.scheduleListById(int.parse(authData.userId!), widget.pickedDate.month.toString(), widget.pickedDate.year.toString(), authData.accessToken!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.data!.isEmpty || snapshot.data!.data!.every((element) => element.schedules!.every((element) => element.booking == null))) {
              return Column(
                children: const [
                  SizedBox(
                    height: 30,
                  ),
                  Icon(
                    Icons.event_busy,
                    size: 70,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No Schedules for today !',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Appointments',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.data![i].schedules!.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.data![i].schedules![index].booking != null) {
                                  final bookingData = snapshot.data!.data![i].schedules![index].booking;
                                  final patientData = bookingData['patient'];
                                  final userProfile = bookingData['patient']['user_profile'];
                                  if (widget.currentSelectedTab == 'Re-Scheduled' && bookingData['status'] != 're_schedule_pending') {
                                    return Container();
                                  } else {
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
                                            leading: widget.currentSelectedTab == 'Accepted'
                                                ? SizedBox(
                                                    width: 108,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        CheckBoxWidget(
                                                          bookingData['id'],
                                                          setBookingId,
                                                        ),
                                                        CircleAvatar(
                                                          radius: 30,
                                                          foregroundImage:
                                                              userProfile['gender'] == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 30,
                                                    foregroundImage: userProfile['gender'] == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                                                  ),
                                            title: Text(
                                              '${patientData['first_name']} ${patientData['last_name']}',
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                            subtitle: RichText(
                                              text: TextSpan(
                                                text:
                                                    'Booking Time: ${DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData['start_time']))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData['end_time']))} \n',
                                                style: const TextStyle(fontSize: 12, height: 1.5),
                                                children: [
                                                  TextSpan(
                                                    text: 'Booking Date: ${DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(bookingData['createdAt']))} \n ',
                                                    style: const TextStyle(height: 1, fontSize: 12),
                                                  ),
                                                  TextSpan(
                                                    text: bookingData['status'],
                                                    style: TextStyle(
                                                        color: bookingData['status'] == 'pending' || bookingData['status'] == 're_schedule_pending'
                                                            ? Colors.yellow
                                                            : bookingData['status'] == 'cancel'
                                                                ? Colors.red
                                                                : bookingData['status'] == 'reject'
                                                                    ? Colors.white
                                                                    : Colors.green,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: const Icon(Icons.arrow_forward_ios),
                                            onTap: () {
                                              patientDetailsTap(
                                                userProfile['gender'],
                                                patientData['first_name'],
                                                patientData['last_name'],
                                                patientData['email'],
                                                ' ${DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(patientData['createdAt']))}',
                                                DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData['start_time'])),
                                                DateFormat.jm().format(DateFormat("hh:mm").parse(bookingData['end_time'])),
                                                userProfile['about'] ?? 'About',
                                                userProfile['address'] ?? 'Address',
                                                bookingData['status'],
                                                bookingData['reason'] ?? 'No reason',
                                                bookingData['id'],
                                                bookingData['createdAt'],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              }),
                        );
                      }),
                ],
              );
            }
          }
        });
  }
}
