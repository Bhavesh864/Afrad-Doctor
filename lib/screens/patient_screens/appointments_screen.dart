// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:afrad_doctor/utils/back_icon_btn.dart';
import '../common_screens/schedule_screen.dart';
import 'doctor_details_screen.dart';
import '../../widgets/button.dart';
import '../../models/patient_models/appointments_by_month.dart' as apn;
import '../../widgets/snackbars_dialogbox.dart';
import '../../providers/auth.dart';
import '../../providers/patient_flow_provider.dart';
import '../../utils/date_utils.dart';
import '../../utils/colors.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appoint-screen';
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? pickedDate = DateTime.now();
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  late ScrollController scrollController;
  var year = DateTime.now().year.toString();
  var month = DateFormat('MM').format(DateTime.now());
  var currentSelectedTab = 'All Appointments';
  List<String> tabsName = ['All Appointments', 'Re-schedule', 'Accepted', 'Cancelled', 'Pending', 'Completed'];
  String requestedStatus = 'all';
  List<String> requestedStatusList = ['all', 'Re_Schedule', 'accepted', 'cancel', 'pending', 'completed'];

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
      initialDate: DateTime.now(),
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

      month = DateFormat('MM').format(pickedDate!);

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
        );
        month = DateFormat('MM').format(pickedDate!);
        currentMonthList = OurDateUtils.daysInMonth(pickedDate!);
        currentMonthList.sort(((a, b) => a.day.compareTo(b.day)));
        currentMonthList = currentMonthList.toSet().toList();
      });
    }
  }

  void datTapHandler() {}

  void navigateToSchedule() {
    Navigator.of(context).pushReplacementNamed(ScheduleScreen.routeName);
  }

  void doctorDetailsTap(String status, int index, int bookingId, int dataId) {
    if (status == 'cancel' || status == 'accepted' || status == 'completed') {
      Navigator.of(context).pushNamed(DoctorDetailScreen.routeName, arguments: {
        'bookingId': bookingId,
        'dataId': dataId,
      });
    } else if (status == 'reject') {
      ShowMessages.showSnackBarMessage('No reason', context);
    } else if (status == 'pending' || status == 're_schedule_pending') {
      ShowMessages.showSnackBarMessage('Your booking status is pending. No Doctor is Assigned To You', context);
    } else {
      ShowMessages.showSnackBarMessage('Something went wrong!', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final gender = authData.userData['user_profile']['gender'];
    final slotData = Provider.of<Bookings>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Appointments',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
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
                  width: 140,
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
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      currentDateTime = currentMonthList[index];
                      year = currentDateTime.year.toString();
                      month = DateFormat('MM').format(currentDateTime);
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
              height: 40,
            ),
            showHorizontalTabs(),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<apn.AppointmentsByMonth>(
              future: slotData.getAppointmentByMonth(month, year, requestedStatus, authData.userId!, authData.accessToken!),
              builder: ((context, snapshot) {
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
                  if (snapshot.data!.data!.isNotEmpty) {
                    return SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: snapshot.data!.data![index].bookings!.length,
                                itemBuilder: (context, i) {
                                  final appointmentData = snapshot.data!.data![index].bookings![i];
                                  return Container(
                                    width: 400,
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
                                            foregroundImage: gender == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                                          ),
                                          title: Text(
                                            '${appointmentData.patient!.firstName} ${appointmentData.patient!.lastName}',
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          subtitle: RichText(
                                            text: TextSpan(
                                              text:
                                                  'Booking Time: ${DateFormat.jm().format(DateFormat("hh:mm").parse(appointmentData.startTime!))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(appointmentData.endTime!))} \n',
                                              style: const TextStyle(fontSize: 12, height: 1.5),
                                              children: [
                                                TextSpan(
                                                  text: 'Booking Date: ${DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(appointmentData.createdAt!))} \n ',
                                                  style: const TextStyle(height: 1, fontSize: 12),
                                                ),
                                                TextSpan(
                                                  text: '${appointmentData.status}',
                                                  style: TextStyle(
                                                    color: appointmentData.status == 'pending'
                                                        ? Colors.yellow
                                                        : appointmentData.status == 'cancel'
                                                            ? Colors.red
                                                            : appointmentData.status == 'reject'
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
                                            doctorDetailsTap(snapshot.data!.data![index].bookings![i].status!, i, snapshot.data!.data![index].bookings![i].id!, snapshot.data!.data![index].id!);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        const Icon(
                          Icons.event_busy,
                          size: 70,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'No Schedules Available !',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                          child: Button(primaryColor, 'Make Appointment', navigateToSchedule),
                        ),
                      ],
                    );
                  }
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
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
