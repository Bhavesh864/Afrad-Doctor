import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../utils/date_utils.dart';
import '../../widgets/patient_widgets/schedules_slot.dart';
import '../../utils/colors.dart';
import '../../providers/patient_flow_provider.dart';
import '../../widgets/snackbars_dialogbox.dart';
import '../doctor_screens/reschedul_all_screen.dart';
import '../doctor_screens/patient_details_screen.dart';
import 'package:afrad_doctor/widgets/doctor_widgets/doctor_shedules_listtiles.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule-screen';
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? pickedDate = DateTime.now();
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  late ScrollController scrollController;
  List morningSlotList = [];
  List afterNoonList = [];
  List eveningList = [];
  var currentSelectedTab = 'Available Bookings';

  @override
  void initState() {
    super.initState();
    currentMonthList = OurDateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort(((a, b) => a.day.compareTo(b.day)));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController = ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
  }

  void openDatePickerDialog() {
    showDatePicker(
      context: context,
      initialDate: pickedDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }

      pickedDate = pickedData;

      pickedDate ??= DateTime.now();

      currentMonthList = OurDateUtils.daysInMonth(pickedData);
      currentMonthList.sort(((a, b) => a.day.compareTo(b.day)));
      currentMonthList = currentMonthList.toSet().toList();
      currentDateTime = pickedDate ?? DateTime.now();

      setState(() {});
    });
  }

  void changeCurrentMonth(String work) {
    if (pickedDate != null) {
      setState(() {
        pickedDate = DateTime(
          pickedDate!.year,
          work == 'dec' ? pickedDate!.month - 1 : pickedDate!.month + 1,
          pickedDate!.day,
          work == 'dec' ? currentDateTime.month - 1 : currentDateTime.month + 1,
        );
        currentMonthList = OurDateUtils.daysInMonth(pickedDate!);
        currentMonthList.sort(((a, b) => a.day.compareTo(b.day)));
        currentMonthList = currentMonthList.toSet().toList();
      });
    }
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
  ) {
    if (status == 'cancel' || status == 'accepted') {
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
    final slotData = Provider.of<Bookings>(context, listen: false);
    // final docData = Provider.of<DoctorSchedules>(context, listen: false);
    final userData = authData.userData;
    final type = userData['type'];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Manage Calender',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: activitiesBackgroundColor,
                      child: IconButton(
                        onPressed: openDatePickerDialog,
                        icon: const Icon(
                          Icons.calendar_month,
                          size: 25,
                        ),
                      ),
                    ),
                    Text(
                      pickedDate == null ? DateFormat.yMMMM().format(DateTime.now()).toString() : DateFormat.yMMMM().format(pickedDate!).toString(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          changeCurrentMonth('dec');
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    IconButton(
                        onPressed: () {
                          changeCurrentMonth('inc');
                        },
                        icon: const Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 80,
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        currentDateTime = currentMonthList[index];
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.all(10),
                        height: 10,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: borderColor),
                          color: currentMonthList[index].day != currentDateTime.day ? activitiesBackgroundColor : primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat.E().format(currentMonthList[index])),
                            Text(DateFormat('dd').format(currentMonthList[index])),
                          ],
                        ),
                      ),
                    );
                  }),
                  itemCount: currentMonthList.length,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              type == 'doctor'
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: OutlinedButton(
                                onPressed: () {
                                  currentSelectedTab = 'Available Bookings';
                                  setState(() {});
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: currentSelectedTab == 'Available Bookings' ? primaryColor : activitiesBackgroundColor,
                                ),
                                child: const Text(
                                  'Available Bookings',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: OutlinedButton(
                                onPressed: () {
                                  currentSelectedTab = 'Re-Scheduled';
                                  setState(() {});
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: currentSelectedTab == 'Re-Scheduled' ? primaryColor : activitiesBackgroundColor,
                                ),
                                child: const Text(
                                  'Re-Scheduled',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(ReScheduleAllScreen.routeName);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.check_box),
                            title: Text('Do you want to reshedule all bookings?'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DoctorSchedulesListTiles(pickedDate!, currentSelectedTab, () {}),
                      ],
                    )
                  : FutureBuilder(
                      future: slotData.getTimeSlotByDate(DateFormat('yyyy-MM-dd').format(pickedDate!).toString(), authData.accessToken!),
                      builder: (context, slotSnapshot) {
                        if (slotSnapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          );
                        } else {
                          morningSlotList.clear();
                          afterNoonList.clear();
                          eveningList.clear();
                          slotData.slotTimingsData['data'].forEach((element) {
                            var startTime = DateFormat.H().format(DateFormat("hh:mm:ss").parse(element['start_time']));
                            var isContainsAM = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(element['start_time'])).contains('AM');

                            var intValStart = int.parse(startTime);

                            if (intValStart < 12 && intValStart != 0 && isContainsAM) {
                              morningSlotList.add(element);
                            } else if ((intValStart > 12 || intValStart == 0) && !isContainsAM) {
                              afterNoonList.add(element);
                            } else if (intValStart < 8 && !isContainsAM) {
                              eveningList.add(element);
                            }
                          });
                          return morningSlotList.isEmpty && afterNoonList.isEmpty && eveningList.isEmpty
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
                              : AvailaibleSlots(
                                  morningSlotList,
                                  afterNoonList,
                                  eveningList,
                                  DateFormat('yyyy-MM-dd').format(currentDateTime),
                                );
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
