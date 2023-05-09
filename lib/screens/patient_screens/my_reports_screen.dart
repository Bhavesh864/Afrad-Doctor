import 'package:afrad_doctor/screens/patient_screens/report_image_overviewscreen.dart';
import 'package:afrad_doctor/widgets/empty_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/patient_flow_provider.dart';
import 'package:afrad_doctor/models/patient_models/patient_all_reports.dart';
import 'package:afrad_doctor/screens/patient_screens/reports_detail_screen.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/utils/colors.dart';

class MyReportScreen extends StatefulWidget {
  static const routeName = '/my_reports';
  const MyReportScreen({super.key});

  @override
  State<MyReportScreen> createState() => _MyReportScreenState();
}

class _MyReportScreenState extends State<MyReportScreen> {
  @override
  Widget build(BuildContext context) {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text('My Reports'),
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
      ),
      body: FutureBuilder<PatientAllReports>(
          future: slotData.patientAllReports(authData.userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              if (snapshot.data!.data!.every((element) => element.report!.isEmpty || snapshot.data!.data!.isEmpty)) {
                return const EmptyScreen('Reports', 'reports');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: ((context, index) {
                      if (snapshot.data!.data![index].status != 'completed' || snapshot.data!.data![index].report!.isEmpty) {
                        return Container();
                      } else if (snapshot.data!.data!.isNotEmpty) {
                        final reportData = snapshot.data!.data![index].report;
                        final doctorData = snapshot.data!.data![index].doctor;
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: borderColor,
                                width: 2.0,
                              ),
                            ),
                            color: scheduleDays,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) => ReportImageOverviewScreen('http://168.235.81.206:7100/${reportData[index].path}')),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      clipBehavior: Clip.none,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          'http://168.235.81.206:7100/${reportData![0].path}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(reportData[0].name!),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('${doctorData!.firstName!} ${doctorData.lastName}'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.access_time_rounded,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(reportData[0].createdAt!)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                ReportsDetailScreen.routeName,
                                                arguments: reportData,
                                              );
                                            },
                                            child: Text(
                                              'See Reports',
                                              style: TextStyle(
                                                color: secondaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Image.asset('assets/left_arrow.png'),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('No Reports Available!'),
                        );
                      }
                    }));
              }
            }
          }),
    );
  }
}
