import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/patient_models/patient_dashboard.dart';
import '../../providers/auth.dart';
import '../../providers/patient_flow_provider.dart';
import '../../screens/patient_screens/doctor_details_screen.dart';
import '../../screens/common_screens/schedule_screen.dart';
import '../../utils/colors.dart';
import '../button.dart';
import '../snackbars_dialogbox.dart';

class PatientDashboardListTiles extends StatefulWidget {
  final Function onRefresh;
  const PatientDashboardListTiles(this.onRefresh, {super.key});

  @override
  State<PatientDashboardListTiles> createState() => _PatientDashboardListTilesState();
}

class _PatientDashboardListTilesState extends State<PatientDashboardListTiles> {
  void doctorDetailsTap(String status, String reason, int bookingId) {
    if (status == 'cancel' || status == 'accepted' || status == 'completed') {
      Navigator.of(context).pushNamed(DoctorDetailScreen.routeName, arguments: {'bookingId': bookingId});
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
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    final userData = authData.userData;
    final gender = userData['user_profile']['gender'];

    return FutureBuilder<PatientDashboard>(
      future: slotData.patientDashBoard(authData.accessToken!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        } else {
          if (snapshot.data?.data!.booking != null) {
            final booking = snapshot.data!.data!.booking!;
            // String? getStatusText() {
            //   return booking.status == 'accepted'
            //       ? 'Accepted'
            //       : booking.status == 'completed'
            //           ? 'Completed'
            //           : booking.status == 'pending'
            //               ? 'Pending'
            //               : booking.status == 'cancelled'
            //                   ? 'Cancelled'
            //                   : booking.status == 'reject' ?
            //                      'Rejected' : booking.status;
            // }

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Last made Appointment',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    await widget.onRefresh();
                  },
                  child: Container(
                    width: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: scheduleDays,
                    ),
                    child: ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        radius: 30,
                        foregroundImage: gender == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                      ),
                      title: Text(
                        '${booking.patient!.firstName} ${booking.patient!.lastName}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text: 'Booking Time: ${DateFormat.jm().format(DateFormat("hh:mm").parse(booking.startTime!))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(booking.endTime!))} \n',
                          style: const TextStyle(fontSize: 12, height: 1.5),
                          children: [
                            TextSpan(
                              text: 'Booking Date: ${DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(booking.createdAt!))}  \n ',
                              style: const TextStyle(height: 1, fontSize: 12),
                            ),
                            TextSpan(
                              text: booking.status == 'accepted'
                                  ? 'Accepted'
                                  : booking.status == 'completed'
                                      ? 'Completed'
                                      : booking.status,
                              style: TextStyle(
                                color: booking.status == 'pending'
                                    ? Colors.yellow
                                    : booking.status == 'cancel' || booking.status == 'reject'
                                        ? Colors.red
                                        : booking.status == 'completed'
                                            ? primaryColor
                                            : secondaryColor,
                                height: 1.5,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        doctorDetailsTap(booking.status!, booking.reason ?? 'No reason', booking.id!);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Last made Appointment',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('You do not make an appointment yet Click on book now to make an appointment'),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(primaryColor, 'Book Now', () {
                    Navigator.of(context).pushNamed(ScheduleScreen.routeName);
                  }),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
