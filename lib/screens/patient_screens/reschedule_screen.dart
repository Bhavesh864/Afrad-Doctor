import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/patient_flow_provider.dart';
import 'package:afrad_doctor/utils/colors.dart';
import 'package:afrad_doctor/widgets/doctor_widgets/reshcedule_slots.dart';

class RescheduleScreen extends StatefulWidget {
  const RescheduleScreen({super.key});

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  DateTime dateTime = DateTime.now();
  DateTime now = DateTime.now();
  DateTime? pickedDate = DateTime.now();
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List slotList = [];

  @override
  Widget build(BuildContext context) {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          elevation: 0,
          title: const Text('Do you want to Re-schedule ?'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                buildDatePicker(),
                const SizedBox(
                  height: 70,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Select Time Slot',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: slotData.getTimeSlotByDate(DateFormat('yyyy-MM-dd').format(dateTime).toString(), authData.accessToken!),
                  builder: (context, slotSnapshot) {
                    if (slotSnapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 267,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    } else {
                      slotList.clear();
                      slotData.slotTimingsData['data'].forEach((element) {
                        // var startTime = DateFormat.H().format(DateFormat("hh:mm:ss").parse(element['start_time']));
                        // var isContainsAM = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(element['start_time'])).contains('AM');

                        // var intValStart = int.parse(startTime);

                        slotList.add(element);
                      });
                      return slotData.slotTimingsData['data'].isEmpty
                          ? Column(
                              children: const [
                                SizedBox(
                                  height: 70,
                                ),
                                Icon(
                                  Icons.event_busy,
                                  size: 70,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'No Schedules Available !',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            )
                          : RescheduleSlots(slotList, dateTime);
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumDate: now,
          minimumYear: 2023,
          maximumYear: DateTime.now().year,
          initialDateTime: now,
          dateOrder: DatePickerDateOrder.dmy,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) => setState(() => this.dateTime = dateTime),
        ),
      );
}
