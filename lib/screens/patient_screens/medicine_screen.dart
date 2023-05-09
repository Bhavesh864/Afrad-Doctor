import 'package:afrad_doctor/screens/patient_screens/medicines_animated_tiles.dart';
import 'package:afrad_doctor/widgets/empty_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:afrad_doctor/utils/colors.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/models/patient_models/patient_medicine_details.dart';

import '../../providers/patient_flow_provider.dart';

class MedicineScreen extends StatefulWidget {
  static const routeName = '/medicine-screen';
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  @override
  Widget build(BuildContext context) {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        leading: const BackIconButton(),
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
              return const EmptyScreen('Medicines', 'medicine');
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.data!.patient!.length,
                    itemBuilder: ((context, index) {
                      final patientData = snapshot.data!.data!.patient![index];
                      return Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.calendar_month),
                            title: Text('Booking Date: ${DateFormat('dd MMMM, yyyy').format(DateTime.parse(patientData.createdAt!))}'),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: patientData.medicines!.length,
                              itemBuilder: ((context, i) {
                                final medicineData = patientData.medicines![i];
                                return MedicinesAnimatedTiles(medicineData, patientData.feedback!, patientData.doctor!);
                              })),
                        ],
                      );
                    })),
              );
            }
          }
        },
      ),
    );
  }
}
