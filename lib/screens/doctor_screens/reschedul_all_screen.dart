import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/doctor_flow_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';
import '../../widgets/snackbars_dialogbox.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/widgets/doctor_widgets/doctor_shedules_listtiles.dart';

class ReScheduleAllScreen extends StatefulWidget {
  static const routeName = '/bookings-screen';
  const ReScheduleAllScreen({super.key});

  @override
  State<ReScheduleAllScreen> createState() => _ReScheduleAllScreenState();
}

class _ReScheduleAllScreenState extends State<ReScheduleAllScreen> {
  List<int> selectedBookingIdList = [];
  void receiveListOfBookingId(List<int> bookingIdList) {
    selectedBookingIdList = bookingIdList;
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final docData = Provider.of<DoctorSchedules>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.check_box_outlined),
              title: Text('February 2023 Bookings'),
            ),
            const SizedBox(
              height: 20,
            ),
            DoctorSchedulesListTiles(DateTime.now(), 'Accepted', receiveListOfBookingId)
          ],
        ),
      ),
      bottomNavigationBar: Container(
          color: mobileBackgroundColor,
          margin: const EdgeInsets.all(8),
          child: Button(primaryColor, 'Request a Re-schedule', () async {
            final result = await docData.applyReshcedule(authData.accessToken!, selectedBookingIdList);
            if (result == 'Re-schedule apply successfully') {
              showDialog(
                  context: context,
                  builder: ((ctx) {
                    return AlertDialog(
                      title: const Text('Your request for re-schedule has been subitted successfully'),
                      actions: [
                        Button(primaryColor, 'View Bookings', () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        })
                      ],
                    );
                  }));
            } else {
              // ignore: use_build_context_synchronously
              ShowMessages.showErrorDialog(result, context);
            }
          })),
    );
  }
}
