import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:afrad_doctor/providers/auth.dart';
import '../../screens/patient_screens/appointments_screen.dart';
import '../button.dart';
import '../snackbars_dialogbox.dart';
import '../../providers/patient_flow_provider.dart';
import '../../utils/colors.dart';

class AvailaibleSlots extends StatefulWidget {
  final List morningSlotList;
  final List afternoonSlotList;
  final List eveningSlotList;
  final String selectedDate;
  const AvailaibleSlots(this.morningSlotList, this.afternoonSlotList, this.eveningSlotList, this.selectedDate, {super.key});

  @override
  State<AvailaibleSlots> createState() => _AvailaibleSlotsState();
}

class _AvailaibleSlotsState extends State<AvailaibleSlots> {
  // ignore: prefer_typing_uninitialized_variables
  var currentSelected;

  void proceedHandler() async {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    final result = await slotData.addBooking(widget.selectedDate, currentSelected['start_time'], currentSelected['end_time'], authData.accessToken!);

    if (result) {
      showDialog(
        context: context,
        builder: ((ctx) {
          return AlertDialog(
            title: const Text('Your booking appointment has been submitted successfully'),
            backgroundColor: activitiesBackgroundColor,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(ctx).pushNamed(AppointmentScreen.routeName);
                  },
                  child: Text(
                    'View Bookings',
                    style: TextStyle(color: secondaryColor),
                  ))
            ],
          );
        }),
      );
    } else {
      // ignore: use_build_context_synchronously
      ShowMessages.showSnackBarMessage("You already have an appointment You cannot book an appointment until the completeion of other Appointments", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Bookings>(
      builder: (context, slotData, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Available booking slots',
                  style: TextStyle(height: 2),
                ),
                subtitle: Text(
                  'Pick a suitable slot for you',
                  style: TextStyle(height: 2),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 30),
                      child: const Text(
                        'Morning ☀️',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.morningSlotList.length,
                        itemBuilder: (context, index) {
                          var morningStart = DateFormat.jm().format(DateFormat("hh:mm").parse(widget.morningSlotList[index]['start_time']));
                          var morningEnd = DateFormat.jm().format(DateFormat("hh:mm").parse(widget.morningSlotList[index]['end_time']));

                          return Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              color: currentSelected == widget.morningSlotList[index] ? primaryColor : activitiesBackgroundColor,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                currentSelected = widget.morningSlotList[index];
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
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 30),
                      child: const Text(
                        'Afternoon 🌞',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.afternoonSlotList.length,
                        itemBuilder: (context, index) {
                          var afternoonStart = DateFormat.jm().format(DateFormat("hh:mm").parse(widget.afternoonSlotList[index]['start_time']));
                          var afternoonEnd = DateFormat.jm().format(DateFormat("hh:mm").parse(widget.afternoonSlotList[index]['end_time']));

                          return Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              color: currentSelected == widget.afternoonSlotList[index] ? primaryColor : activitiesBackgroundColor,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                currentSelected = widget.afternoonSlotList[index];
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
                                      '$afternoonStart - $afternoonEnd ',
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
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 30),
                      child: const Text(
                        'Evening 🌅',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              color: currentSelected == widget.morningSlotList[index] ? primaryColor : activitiesBackgroundColor,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                currentSelected = widget.morningSlotList[index];
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
                                    child: const Text(
                                      'No ',
                                      style: TextStyle(
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
                    currentSelected != null ? Button(primaryColor, 'Proceed', proceedHandler) : Container(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Widget doctorTimingsData(String startTime, String endTime, var isSelected, int selectedIndex, Function onTapHandler) {
//   return Container(
//     margin: const EdgeInsets.only(left: 10, top: 10),
//     decoration: BoxDecoration(
//       color: primaryColor,
//       border: Border.all(color: Colors.white),
//       borderRadius: BorderRadius.circular(5),
//     ),
//     child: InkWell(
//       onTap: (() => onTapHandler),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(right: 2),
//             child: const Icon(
//               Icons.access_time,
//               color: Colors.white,
//               size: 18,
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 2),
//             child: Text(
//               '$startTime - $endTime ',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontFamily: 'Roboto',
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
