// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:afrad_doctor/screens/common_screens/notification_screen.dart';
import 'package:afrad_doctor/screens/common_screens/profile_screen.dart';
import 'package:afrad_doctor/screens/doctor_screens/my_schedules_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/appointments_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/medicine_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/my_doctor_list_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/my_prescription_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/my_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';
import '../../../providers/patient_flow_provider.dart';
import '../../../providers/doctor_flow_provider.dart';
import '../../../utils/colors.dart';
import '../../../widgets/doctor_widgets/doctor_dashboard_listtiles.dart';
import '../../../widgets/patient_widgets/patient_dashboard_listtiles.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var year = DateTime.now().year.toString();
  var month = DateFormat('MM').format(DateTime.now());
  var type;
  var gender;
  var authData;
  var userData;

  Widget activitiesTabs(String imgText, String text, onTapHandler) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTapHandler,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: dashboardTabs,
          ),
          height: 150,
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/$imgText.png'),
              const SizedBox(
                height: 10,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    final authData = Provider.of<Auth>(context, listen: false);
    userData = authData.userData;
    type = userData['type'];
    gender = userData['user_profile']['gender'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final docData = Provider.of<DoctorSchedules>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final slotData = Provider.of<Bookings>(context, listen: false);
    final image = userData['image'];

    void navigateToAppointment() {
      if (type == 'patient') {
        Navigator.of(context).pushNamed(AppointmentScreen.routeName);
      }
    }

    Future<void> onRefreshDoctor() async {
      await docData.doctorDashboard(date, authData.accessToken!);
      setState(() {});
    }

    Future<void> onRefreshPatient() async {
      await slotData.patientDashBoard(authData.accessToken!);
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.black,
        onRefresh: () async {
          type == 'patient' ? await onRefreshPatient() : await onRefreshDoctor();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                minLeadingWidth: 50,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                  child: image != null
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 3),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage("http://168.235.81.206:7100/$image"),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 3),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: gender == 'Male' ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                          ),
                        ),
                ),
                title: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                  child: Text("Hi ! ${userData['first_name']} ${userData['last_name']}"),
                ),
                subtitle: type == 'patient' ? const Text('You\'r Patient') : const Text("You'r Doctor"),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(NotificationScreen.routeName);
                  },
                  icon: const Icon(
                    Icons.notifications_outlined,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              type != 'doctor'
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: PatientDashboardListTiles(onRefreshPatient),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: DoctorDashboardListTiles(onRefreshDoctor),
                    ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Explore your activities',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              type == 'doctor'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          activitiesTabs(
                            // Icons.pending_actions,
                            'patient/appointment',
                            'Schedules',
                            () {
                              Navigator.of(context).pushNamed(DoctorSchedulesScreen.routeName);
                            },
                          ),
                          activitiesTabs(
                            // Icons.calendar_month,
                            'doctor/holidays',
                            'Holidays',
                            () {},
                          ),
                          activitiesTabs(
                            // Icons.description,
                            'patient/reports',
                            'Re-scheduled',
                            () {},
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          activitiesTabs(
                            // Icons.pending_actions,
                            'patient/appointment',
                            'Appointments',
                            navigateToAppointment,
                          ),
                          activitiesTabs(
                            // Icons.calendar_month,
                            'patient/prescription',
                            'My Presciption',
                            () {
                              Navigator.of(context).pushNamed(MyPrescriptionScreen.routeName);
                            },
                          ),
                          activitiesTabs(
                            // Icons.description,
                            'patient/reports',
                            'My Reports',
                            () {
                              Navigator.of(context).pushNamed(MyReportScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              type == 'doctor'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          activitiesTabs(
                            // Icons.personal_injury_rounded,
                            'patient/my_doctor',
                            'My Patient',
                            () {},
                          ),
                          activitiesTabs(
                            // Icons.payments_outlined,
                            'doctor/earnings',
                            'Earnings',
                            () {},
                          ),
                          activitiesTabs(
                            // Icons.comment,
                            'patient/chat',
                            'Chat with Patient',
                            () {},
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          activitiesTabs(
                            // Icons.medication,
                            'patient/my_doctor',
                            'My Doctor',
                            () {
                              Navigator.of(context).pushNamed(MyDoctorListScreen.routeName);
                            },
                          ),
                          activitiesTabs(
                            // Icons.medication_liquid,
                            'patient/medicine',
                            'Medicine',
                            () {
                              Navigator.of(context).pushNamed(MedicineScreen.routeName);
                            },
                          ),
                          activitiesTabs(
                            // Icons.comment,
                            'patient/chat',
                            'Chat with us',
                            () {},
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'News & tips for you',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 450,
                height: 80,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dashboardTabs,
                      ),
                      width: 300,
                      child: ListTile(
                        leading: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/medicines_2.jpeg',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 200,
                          ),
                        ),
                        title: const Text(
                          'Avoid harmone replacement therapy',
                          style: TextStyle(fontSize: 13, height: 1.2),
                        ),
                        subtitle: const Text(
                          'Avoid harmone replacement therapy',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dashboardTabs,
                      ),
                      width: 300,
                      child: ListTile(
                        leading: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/medicines_3.jpeg',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 100,
                          ),
                        ),
                        title: const Text(
                          'Avoid harmone replacement therapy',
                          style: TextStyle(fontSize: 13, height: 1.2),
                        ),
                        subtitle: const Text(
                          'Avoid harmone replacement therapy',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dashboardTabs,
                      ),
                      width: 300,
                      child: ListTile(
                        leading: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/medicines.jpeg',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 100,
                          ),
                        ),
                        title: const Text(
                          'Avoid harmone replacement therapy',
                          style: TextStyle(fontSize: 13, height: 1.2),
                        ),
                        subtitle: const Text(
                          'Avoid harmone replacement therapy',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
