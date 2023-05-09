import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/doctor_models/doctor_dashboard.dart';
import '../../providers/auth.dart';
import '../../providers/doctor_flow_provider.dart';
import '../../screens/doctor_screens/patient_details_screen.dart';
import '../../utils/colors.dart';
import '../snackbars_dialogbox.dart';

class DoctorDashboardListTiles extends StatefulWidget {
  final Function onRefresh;
  const DoctorDashboardListTiles(this.onRefresh, {super.key});

  @override
  State<DoctorDashboardListTiles> createState() => _DoctorDashboardListTilesState();
}

class _DoctorDashboardListTilesState extends State<DoctorDashboardListTiles> {
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void patientDetailsTap(String gender, String firstName, String lastName, String email, String day, String startTime, String endTime, String about, String address, String status, String reason,
      int bookingId, String bookingDate) {
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

    return FutureBuilder<DoctorDashboard>(
      future: docData.doctorDashboard(date, authData.accessToken!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 147,
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        } else {
          if (snapshot.data!.data!.singleDate!.isEmpty || snapshot.data!.data!.singleDate!.every((element) => element.booking == null)) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Your Today\'s Schedules',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                  height: 20,
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Your Today\'s Schedules',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    // TextButton(onPressed: () {}, child: const Text('View all'))
                  ],
                ),
                RefreshIndicator(
                    onRefresh: () async {
                      await widget.onRefresh();
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.data!.singleDate!.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.data!.singleDate![index].booking == null) {
                            return Container();
                          } else if (snapshot.data!.data!.singleDate![index].booking['status'] != 'accepted') {
                            return Container();
                          }
                          final acceptedData = snapshot.data!.data!.singleDate![index];
                          final acceptedBookingData = snapshot.data!.data!.singleDate![index].booking;
                          final acceptedPatientData = acceptedBookingData['patient'];

                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: scheduleDays,
                            ),
                            child: ListTile(
                              isThreeLine: true,
                              leading: CircleAvatar(
                                radius: 30,
                                foregroundImage:
                                    acceptedPatientData['user_profile']['gender'] == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                              ),
                              title: Text(
                                '${acceptedPatientData["first_name"]} ${acceptedPatientData["last_name"]}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  text:
                                      'Booking Time: ${DateFormat.jm().format(DateFormat("hh:mm").parse(acceptedData.startTime!))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(acceptedData.endTime!))} \n',
                                  style: const TextStyle(fontSize: 12, height: 1.5),
                                  children: [
                                    TextSpan(
                                      text: 'Booking Date: ${DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(acceptedData.createdAt!))}  \n ',
                                      style: const TextStyle(height: 1, fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: acceptedBookingData['status'],
                                      style: TextStyle(
                                        color: acceptedBookingData['status'] == 'pending' || acceptedBookingData['status'] == 're_schedule_pending'
                                            ? Colors.yellow
                                            : acceptedBookingData['status'] == 'cancel'
                                                ? Colors.red
                                                : acceptedBookingData['status'] == 'reject'
                                                    ? Colors.white
                                                    : Colors.green,
                                        height: 1.5,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                patientDetailsTap(
                                    acceptedPatientData['user_profile']['gender'],
                                    acceptedPatientData['first_name'],
                                    acceptedPatientData['last_name'],
                                    acceptedPatientData['email'],
                                    ' ${DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(acceptedBookingData["createdAt"]))}',
                                    DateFormat.jm().format(DateFormat("hh:mm").parse(acceptedData.startTime!)),
                                    DateFormat.jm().format(DateFormat("hh:mm").parse(acceptedData.endTime!)),
                                    acceptedPatientData['user_profile']['about'] ?? 'about',
                                    acceptedPatientData['user_profile']['address'] ?? 'Address',
                                    acceptedBookingData['status'],
                                    acceptedBookingData['reason'] ?? 'No Reason',
                                    acceptedBookingData['id'],
                                    acceptedBookingData['createdAt']);
                              },
                            ),
                          );
                        })),
              ],
            );
          }
        }
      },
    );
  }
}
