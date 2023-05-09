import 'package:afrad_doctor/models/patient_models/patient_medicine_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/back_icon_btn.dart';
import '../../utils/colors.dart';

class PrescriptionDetailsScreen extends StatelessWidget {
  static const routeName = '/prescription-details';
  const PrescriptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as List<Medicines>;

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text('Prescription Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: routeArgs.length,
              itemBuilder: (context, i) {
                var startDate = DateFormat('dd-MMMM').format(DateTime.parse(routeArgs[i].startDate!));
                var endDate = DateFormat('dd-MMMM').format(DateTime.parse(routeArgs[i].endDate!));
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: i < 5 ? const AssetImage('assets/medicine_rep.png') : const AssetImage('assets/medicine_rep_2.png'),
                          ),
                          title: Text(routeArgs[i].medName!),
                          subtitle: Text(routeArgs[i].medType!),
                        ),
                        Divider(
                          thickness: 2,
                          color: borderColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Days of Medicine'),
                                  Text('Date of Medicine'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(routeArgs[i].totalNoOfMedDays.toString()),
                                  Text('$startDate - $endDate'),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Timings to take medicines'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.5, color: borderColor),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Text(routeArgs[i].medTime!)),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Description'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.5, color: borderColor),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(routeArgs[i].medDesc!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ]),
      ),
    );
  }
}
