import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import 'package:afrad_doctor/models/patient_models/patient_medicine_details.dart' as dat;

class MedicinesAnimatedTiles extends StatefulWidget {
  final dat.Medicines medicineData;
  final dat.Feedback feebdackData;
  final dat.Doctor doctorData;
  const MedicinesAnimatedTiles(this.medicineData, this.feebdackData, this.doctorData, {super.key});

  @override
  State<MedicinesAnimatedTiles> createState() => _MedicinesAnimatedTilesState();
}

class _MedicinesAnimatedTilesState extends State<MedicinesAnimatedTiles> {
  var isExpanded = false;
  List<String> medicineInfo = ['Doctor', 'Date of Treatment', 'Days of Treatment', 'Disease'];

  @override
  Widget build(BuildContext context) {
    List<String> medicineInfoAns = [
      '${widget.doctorData.firstName} ${widget.doctorData.lastName}',
      '${DateFormat('dd MMMM').format(DateTime.parse(widget.medicineData.startDate!))} - ${DateFormat('dd MMMM').format(DateTime.parse(widget.medicineData.endDate!))}',
      widget.medicineData.totalNoOfMedDays.toString(),
      widget.feebdackData.disease!
    ];

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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? 240 : 100,
          child: Column(children: [
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Image.asset(
                  'assets/medicine_rep.png',
                  fit: BoxFit.cover,
                ),
                title: Text(
                  widget.medicineData.medName!,
                ),
                subtitle: Text(
                  widget.medicineData.medType!,
                ),
                trailing: IconButton(
                  icon: isExpanded ? const Icon(Icons.expand_less) : const Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ),
            ),
            AnimatedContainer(
              height: isExpanded ? 120 : 0,
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 8000),
                curve: Curves.easeIn,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            medicineInfo[index],
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            medicineInfoAns[index],
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
