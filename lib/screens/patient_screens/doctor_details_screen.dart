// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './reschedule_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/mypresc_myreports_screen.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';
import '../../widgets/patient_widgets/single_selection_dialog.dart';
import '../../models/patient_models/appointments_by_month.dart' as apn;
import '../../providers/auth.dart';
import '../../providers/patient_flow_provider.dart';
import '../../utils/colors.dart';

class DoctorDetailScreen extends StatefulWidget {
  static const routeName = '/doctor_details_screen';
  const DoctorDetailScreen({super.key});

  @override
  State<DoctorDetailScreen> createState() => DoctorDetailScreenState();
}

class DoctorDetailScreenState extends State<DoctorDetailScreen> {
  var year = DateTime.now().year.toString();
  var month = DateFormat('MM').format(DateTime.now());
  final feedbackController = TextEditingController();
  var rating = 1;
  List<String> medicinePrescDetails = ['Medicine name', 'Date of Medicines', 'Days of Medicines', 'Timings'];

  List<String> infoTabsList = [
    'About',
    'Speciality',
    'Experience',
    'Qualification',
  ];
  List<String> selectedTabList = [];
  String selectedTab = 'About';

  void resheduleHandler(bookingId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(arguments: bookingId),
        builder: ((context) => const RescheduleScreen()),
        fullscreenDialog: true,
      ),
    );
  }

  void cancelBookingHandler(bookingId) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Reason for Cancellation'),
            backgroundColor: activitiesBackgroundColor,
            content: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                shape: BoxShape.rectangle,
              ),
              child: SingleSelectionExample(bookingId),
            ),
          );
        });
  }

  void sendFeedback(int doctorId) {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    final ids = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: ((context) {
          return StatefulBuilder(builder: (context, bottomSheetSetState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                padding: const EdgeInsets.all(10),
                color: const Color.fromARGB(255, 12, 24, 34),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Submit your reviews here',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return IconButton(
                              onPressed: () {
                                bottomSheetSetState(() {
                                  rating = index + 1;
                                });
                              },
                              icon: index < rating
                                  ? const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 28,
                                    )
                                  : const Icon(
                                      Icons.star_border,
                                      color: Colors.amber,
                                      size: 28,
                                    ),
                            );
                          }),
                    ),
                    TextField(
                      controller: feedbackController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Send your feedback',
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.white),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(primaryColor),
                            ),
                            onPressed: () async {
                              final res = await slotData.patientFeedback(ids.values.first, doctorId, rating, feedbackController.text, authData.accessToken!);

                              if (res) {
                                Navigator.of(context).pop();
                                ShowMessages.showSnackBarMessage('Thank You for you feedback', context);
                              } else {
                                Navigator.of(context).pop();
                                ShowMessages.showErrorDialog('Something went wrong! Please provide all required details and try again.', context);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.white),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    final ids = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final authData = Provider.of<Auth>(context, listen: false);
    final slotData = Provider.of<Bookings>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        toolbarHeight: 50,
        leading: const BackIconButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<apn.AppointmentsByMonth>(
            future: slotData.getAppointmentByMonth(month, year, 'all', authData.userId!, authData.accessToken!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              } else {
                final bookingId = ids.values.first;
                final dataId = ids.values.last;

                final dataIndex = snapshot.data!.data!.indexWhere((element) => element.id == dataId);
                final bookingData = snapshot.data!.data![dataIndex < 0 ? snapshot.data!.data!.length - 1 : dataIndex].bookings!.firstWhere((element) => element.id == bookingId);
                final doctorData = bookingData.doctor;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: activitiesBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor, width: 3),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: doctorData!.image == null
                                      ? CircleAvatar(
                                          radius: 60,
                                          backgroundImage: doctorData.userProfile!.gender == "Male" ? const AssetImage('assets/male_profile.jpeg') : const AssetImage('assets/female_profile.jpeg'),
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(60),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(60),
                                            child: Image.network(
                                              'http://168.235.81.206:7100/${doctorData.image}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${doctorData.firstName} ${doctorData.lastName}",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  doctorData.email!,
                                  style: const TextStyle(fontSize: 12, letterSpacing: 0.8),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                bookingData.status == 'accepted'
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor: const MaterialStatePropertyAll(activitiesBackgroundColor),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      side: BorderSide(color: borderColor),
                                                    ),
                                                  )),
                                              onPressed: () {
                                                resheduleHandler(bookingData.id);
                                              },
                                              child: const Text('Request a Re-schedule'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor: const MaterialStatePropertyAll(Colors.red),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18.0),
                                                    side: BorderSide(color: borderColor),
                                                  ),
                                                )),
                                            onPressed: () {
                                              cancelBookingHandler(bookingData.id);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      )
                                    : bookingData.status == 'completed'
                                        ? OutlinedButton(
                                            onPressed: (() {
                                              sendFeedback(bookingData.doctor!.id!);
                                            }),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(activitiesBackgroundColor),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'Send Feedback',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          )
                                        : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Appointment Schedules',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: darkPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                            ' ${DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(doctorData.createdAt!))}',
                            style: const TextStyle(height: 2),
                          ),
                          subtitle: Text(
                            '${DateFormat.jm().format(DateFormat('hh:mm').parse("${bookingData.startTime}"))} - ${DateFormat.jm().format(DateFormat('hh:mm').parse("${bookingData.endTime}"))}',
                            style: const TextStyle(height: 2),
                          ),
                          trailing: Text(
                            'Status: ${bookingData.status}',
                            style: TextStyle(
                              color: bookingData.status == 'pending'
                                  ? Colors.yellow
                                  : bookingData.status == 'cancel'
                                      ? Colors.red
                                      : bookingData.status == 'completed'
                                          ? primaryColor
                                          : secondaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Appointment Information',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
                            color: borderColor,
                            width: 2.0,
                          ),
                        ),
                        color: activitiesBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 370,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: infoTabsList.length,
                                    itemBuilder: ((context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedTab = infoTabsList[index];
                                            });
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: selectedTab == infoTabsList[index] ? primaryColor : activitiesBackgroundColor,
                                          ),
                                          child: Text(
                                            infoTabsList[index],
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              selectedTab == 'About'
                                  ? Column(
                                      children: [
                                        ListTile(
                                          isThreeLine: true,
                                          title: const Text('Clinic Address'),
                                          subtitle: Text('${doctorData.clinic!.name}, ${doctorData.clinic!.address}, \n ${doctorData.clinic!.city}, ${doctorData.clinic!.state}'),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        ListTile(
                                          title: const Text('Phone Number', style: TextStyle(height: 2)),
                                          subtitle: Text(doctorData.phone!),
                                        ),
                                      ],
                                    )
                                  : selectedTab == 'Speciality'
                                      ? ListTile(
                                          title: const Text('Speciality', style: TextStyle(height: 3)),
                                          subtitle: Text(doctorData.userProfile!.specility!),
                                        )
                                      : selectedTab == 'Experience'
                                          ? ListTile(
                                              title: const Text(
                                                'Experience',
                                                style: TextStyle(height: 3),
                                              ),
                                              subtitle: Text('${doctorData.userProfile!.experience!.toString()} Years'),
                                            )
                                          : selectedTab == 'Qualification'
                                              ? ListTile(
                                                  title: const Text('Qualification', style: TextStyle(height: 3)),
                                                  subtitle: Text(doctorData.userProfile!.qualification!),
                                                )
                                              : Container(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      bookingData.status == 'completed'
                          ? Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Medicine & Prescription Details',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: borderColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  color: activitiesBackgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25),
                                          child: Row(
                                            children: [
                                              const Text('Disease'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                bookingData.feedback['disease'],
                                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ClampingScrollPhysics(),
                                            itemCount: bookingData.medicines!.length,
                                            itemBuilder: (context, i) {
                                              return Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: const ClampingScrollPhysics(),
                                                    itemCount: 4,
                                                    itemBuilder: ((context, index) {
                                                      var medicinesData = bookingData.medicines![i];
                                                      var startDate = DateFormat('dd-MMMM').format(DateTime.parse(medicinesData['start_date']));
                                                      var endDate = DateFormat('dd-MMMM').format(DateTime.parse(medicinesData['end_date']));
                                                      List doctorPres = [
                                                        medicinesData['med_name'],
                                                        "$startDate - $endDate",
                                                        "${medicinesData['total_no_of_med_days']}",
                                                        medicinesData['med_time'],
                                                      ];
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(medicinePrescDetails[index]),
                                                            const SizedBox(
                                                              width: 30,
                                                            ),
                                                            Text(
                                                              doctorPres[index],
                                                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    })),
                                              );
                                            }),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(MyPrescMyReportsScreen.routeName, arguments: {
                                      'medicineList': bookingData.medicines,
                                      'reportList': bookingData.report,
                                    });
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                                    backgroundColor: MaterialStateProperty.all(activitiesBackgroundColor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'View Prescription Reports',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> indexedMap<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }
}
