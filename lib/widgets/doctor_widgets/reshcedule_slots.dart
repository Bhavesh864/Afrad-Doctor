// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/patient_flow_provider.dart';
import '../../utils/colors.dart';
import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/screens/app_screens/tab_bar_screen.dart';
import 'package:afrad_doctor/widgets/button.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';

class RescheduleSlots extends StatefulWidget {
  final List availableSlotList;
  final DateTime pickedDate;
  const RescheduleSlots(this.availableSlotList, this.pickedDate, {super.key});

  @override
  State<RescheduleSlots> createState() => RescheduleSlotsState();
}

class RescheduleSlotsState extends State<RescheduleSlots> {
  var currentSelected;
  var morningStart;
  var morningEnd;
  var bookingId;

  void confirmHandler() async {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    var pickedStartTime = DateFormat('hh:mm').format(
      DateFormat('hh:mm').parse(currentSelected['start_time']),
    );
    var pickedEndTime = DateFormat('hh:mm').format(
      DateFormat('hh:mm').parse(currentSelected['end_time']),
    );
    var selectedDate = DateFormat('yyyy-MM-dd').format(widget.pickedDate);

    final res = await slotData.applyRescheduleByPatient(selectedDate, pickedStartTime, pickedEndTime, bookingId, authData.accessToken!);

    if (res == 'Re-schedule apply successfully') {
      showDialog(
        context: context,
        builder: ((ctx) {
          return AlertDialog(
            backgroundColor: activitiesBackgroundColor,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            buttonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            icon: Image.asset(
              'assets/icons/reschedule.png',
              height: 60,
            ),
            title: const Text('Your request for re-schedule has been subitted successfully'),
            content: const Text('Once the system has approve your request you can see your updated schedule in your booking list'),
            actions: [
              Button(primaryColor, 'View Bookings', () {
                Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
              })
            ],
          );
        }),
      );
    } else {
      // ignore: use_build_context_synchronously
      ShowMessages.showSnackBarMessage(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    bookingId = ModalRoute.of(context)!.settings.arguments as int;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.availableSlotList.length,
            itemBuilder: (context, index) {
              morningStart = DateFormat.jm().format(DateFormat("hh:mm").parse(widget.availableSlotList[index]['start_time']));

              morningEnd = DateFormat.jm().format(DateFormat("hh:mm").parse(widget.availableSlotList[index]['end_time']));
              return Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                  color: currentSelected == widget.availableSlotList[index] ? primaryColor : activitiesBackgroundColor,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    currentSelected = widget.availableSlotList[index];
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 2),
                        child: const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 2),
                        child: Text(
                          '$morningStart - $morningEnd ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.3,
            ),
            shrinkWrap: true,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: secondaryColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            currentSelected != null
                ? TextButton(
                    style: TextButton.styleFrom(foregroundColor: secondaryColor),
                    onPressed: confirmHandler,
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
