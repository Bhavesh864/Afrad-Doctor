import 'package:afrad_doctor/widgets/empty_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/utils/colors.dart';
import '../../providers/patient_flow_provider.dart';
import 'package:afrad_doctor/models/patient_models/patient_medicine_details.dart';
import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/screens/patient_screens/prescription_details_screen.dart';

class MyPrescriptionScreen extends StatefulWidget {
  static const routeName = 'my_prescription';
  const MyPrescriptionScreen({super.key});

  @override
  State<MyPrescriptionScreen> createState() => _MyPrescriptionScreenState();
}

class _MyPrescriptionScreenState extends State<MyPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text('My Prescription'),
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
      ),
      body: FutureBuilder<PatientMedicineDetails>(
          future: slotData.patientMedicineDetails(authData.accessToken!, authData.userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              if (snapshot.data!.data == null || snapshot.data!.data!.patient!.isEmpty) {
                return const EmptyScreen('Prescription', 'prescription');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.data!.patient!.length,
                    itemBuilder: ((context, index) {
                      final patientData = snapshot.data!.data!.patient![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
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
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Image.asset(
                                    'assets/medicine_rep.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(patientData.feedback!.disease!),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('${patientData.doctor!.firstName} ${patientData.doctor!.lastName}'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Given at: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(patientData.createdAt!))}  ${DateFormat.jm().format(DateFormat("hh:mm").parse(patientData.startTime!))}',
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              PrescriptionDetailsScreen.routeName,
                                              arguments: patientData.medicines,
                                            );
                                          },
                                          child: Text(
                                            'See Presciption',
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
                    }));
              }
            }
          }),
    );
  }
}
