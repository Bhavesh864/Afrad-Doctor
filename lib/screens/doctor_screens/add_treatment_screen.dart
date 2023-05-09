// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/colors.dart';
import '../../widgets/button.dart';
import 'package:afrad_doctor/screens/app_screens/tab_bar_screen.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';
import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/providers/doctor_flow_provider.dart';

class AddTreatmentScreen extends StatefulWidget {
  static const routeName = '/add-treatment';
  const AddTreatmentScreen({super.key});

  @override
  State<AddTreatmentScreen> createState() => _AddTreatmentScreenState();
}

class _AddTreatmentScreenState extends State<AddTreatmentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final medicineNameController = [TextEditingController()];
  final medicineTypeController = [TextEditingController()];
  final medicineDescController = [TextEditingController()];

  final diseaseController = TextEditingController();
  final customiseController = TextEditingController();
  final reportTitleController = TextEditingController();

  List<String> treatmentDaysList = ['7 Days', '15 Days', '20 Days', '1 Month', '3 Months', 'Customise'];
  String? selectedTreatmentDays;
  //
  var pickedTreatStartDate;
  String? customiseDaysMonthsYears;
  //
  List<List> selectedMedicineTime = [List.empty(growable: true)];
  //
  var pickedMedStartDate;
  var pickedMedEndDate;
  List startDateList = [DateTime.now()];
  List endDateList = [DateTime.now()];
  //
  int medicineListLength = 1;
  //
  List<File> selectedImage = [];
  //

  List<Map> finalMedicineDetailsList = [];

  void imagePicker() async {
    List<XFile> file = await ImagePicker().pickMultiImage(
      imageQuality: 80,
    );

    if (file.isNotEmpty) {
      for (var i = 0; i < file.length; i++) {
        selectedImage.add(File(file[i].path));
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final docData = Provider.of<DoctorSchedules>(context);
    final authData = Provider.of<Auth>(context);
    final bookingId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text('Add Treatment'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text('Deisease type'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return 'Disease Required!';
                    }
                    return null;
                  },
                  controller: diseaseController,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.arrow_forward_ios_rounded),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Disease',
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5),
                  child: Text('Select date for Treatment'),
                ),
                SizedBox(
                  height: 190,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                    ),
                    itemCount: treatmentDaysList.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        decoration: BoxDecoration(
                          color: selectedTreatmentDays == treatmentDaysList[index] ? primaryColor : activitiesBackgroundColor,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (selectedTreatmentDays == treatmentDaysList[index]) {
                              selectedTreatmentDays = '';
                            } else {
                              selectedTreatmentDays = treatmentDaysList[index];
                            }
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 2),
                                child: Icon(
                                  treatmentDaysList[index] == 'Customise' ? Icons.add : Icons.access_time,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              Container(
                                width: 100,
                                margin: const EdgeInsets.only(left: 2),
                                child: Text(
                                  treatmentDaysList[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                selectedTreatmentDays == 'Customise'
                    ? Column(
                        children: [
                          SizedBox(
                            child: TextFormField(
                              controller: customiseController,
                              style: const TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.grey.shade700),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: 'Customise ',
                                contentPadding: const EdgeInsets.all(20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              treatmentCustomiseDays('Days'),
                              treatmentCustomiseDays('Months'),
                              treatmentCustomiseDays('Years'),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text('Start Date'),
                ),
                TextField(
                  onTap: () async {
                    pickedTreatStartDate = await showDatePicker(context: context, initialDate: pickedTreatStartDate ?? DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2024));
                    setState(() {});
                  },
                  readOnly: true,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: DateFormat('dd-MMMM-yyy').format(pickedTreatStartDate ?? DateTime.now()),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: medicineListLength,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                              ListTile(
                                title: const Text('Add Medicine'),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          medicineListLength++;
                                          generateTextFields();
                                          startDateList.add(DateTime.now());
                                          endDateList.add(DateTime.now());

                                          selectedMedicineTime.add(List.empty(growable: true));

                                          setState(() {});
                                        },
                                        icon: Image.asset('assets/icons/add.png'),
                                      ),
                                      medicineListLength > 1
                                          ? IconButton(
                                              onPressed: () {
                                                medicineListLength--;
                                                selectedMedicineTime.removeAt(index);
                                                setState(() {});
                                              },
                                              icon: Image.asset('assets/icons/remove.png'))
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30, bottom: 10),
                                child: Text('Medicine name'),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 3) {
                                      return 'Medicine name Required!';
                                    }
                                    return null;
                                  },
                                  controller: medicineNameController[index],
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    fillColor: mobileBackgroundColor,
                                    filled: true,
                                    suffixIcon: const Icon(Icons.arrow_forward_ios_rounded),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: Colors.grey.shade700),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    hintText: 'Medicine name',
                                    contentPadding: const EdgeInsets.all(20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30, bottom: 10),
                                child: Text('Medicine type'),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 3) {
                                      return 'Medicine type Required!';
                                    }
                                    return null;
                                  },
                                  controller: medicineTypeController[index],
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    fillColor: mobileBackgroundColor,
                                    filled: true,
                                    suffixIcon: const Icon(Icons.arrow_forward_ios_rounded),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: Colors.grey.shade700),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    hintText: 'Medicine type',
                                    contentPadding: const EdgeInsets.all(20),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30, top: 15),
                                child: Text('Time'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    medicineTimeBatch('Morning', index),
                                    medicineTimeBatch('Afternoon', index),
                                    medicineTimeBatch('Evening', index),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 30, bottom: 10, top: 15),
                                        child: Text('Start Date'),
                                      ),
                                      Container(
                                        width: 170,
                                        height: 50,
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: TextField(
                                          readOnly: true,
                                          onTap: () async {
                                            pickedMedStartDate =
                                                await showDatePicker(context: context, initialDate: startDateList[index] ?? DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2024));

                                            if (pickedMedStartDate != null) {
                                              startDateList.removeAt(index);
                                              startDateList.insert(index, pickedMedStartDate);
                                            }

                                            setState(() {});
                                          },
                                          style: const TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                            fillColor: mobileBackgroundColor,
                                            filled: true,
                                            suffixIcon: const Icon(Icons.calendar_month),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: BorderSide(color: Colors.grey.shade700),
                                            ),
                                            hintText: DateFormat('yyyy-MM-dd').format(startDateList[index] ?? DateTime.now()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 10, top: 15, right: 30),
                                        child: Text('End Date'),
                                      ),
                                      Container(
                                        width: 170,
                                        height: 50,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: TextField(
                                          readOnly: true,
                                          onTap: () async {
                                            pickedMedEndDate =
                                                await showDatePicker(context: context, initialDate: endDateList[index] ?? DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2024));

                                            if (pickedMedEndDate != null) {
                                              endDateList.removeAt(index);
                                              endDateList.insert(index, pickedMedEndDate);
                                            }

                                            setState(() {});
                                          },
                                          style: const TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                            fillColor: mobileBackgroundColor,
                                            filled: true,
                                            suffixIcon: const Icon(Icons.calendar_month),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              borderSide: BorderSide(color: Colors.grey.shade700),
                                            ),
                                            hintText: DateFormat('yyyy-MM-dd').format(endDateList[index] ?? DateTime.now()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                child: Text('Remarks'),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 3) {
                                      return 'Description Required!';
                                    }
                                    return null;
                                  },
                                  controller: medicineDescController[index],
                                  style: const TextStyle(fontSize: 15),
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    fillColor: mobileBackgroundColor,
                                    filled: true,
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
                                    hintText: 'Add your remarks here',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
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
                  color: scheduleDays,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        title: const Text(
                          'Add Medicine',
                        ),
                        trailing: SizedBox(
                          width: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Add image',
                                style: TextStyle(fontSize: 13),
                              ),
                              IconButton(
                                onPressed: imagePicker,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 2,
                      ),
                      selectedImage.isNotEmpty
                          ? SizedBox(
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedImage.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Image.file(
                                            selectedImage[index],
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: -16,
                                            right: -20,
                                            child: IconButton(
                                              onPressed: () {
                                                selectedImage.removeAt(index);
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.dangerous_outlined,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  })),
                            )
                          : Container(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return 'Title Required!';
                            }
                            return null;
                          },
                          controller: reportTitleController,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            fillColor: mobileBackgroundColor,
                            filled: true,
                            suffixIcon: const Icon(Icons.arrow_forward_ios_rounded),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.grey.shade700),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Report Title',
                            contentPadding: const EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Button(primaryColor, 'Submit', () async {
                  if (!formKey.currentState!.validate() ||
                      selectedTreatmentDays == null ||
                      pickedTreatStartDate == null ||
                      pickedMedEndDate == null ||
                      pickedMedStartDate == null ||
                      selectedMedicineTime[0].isEmpty) {
                    return;
                  }

                  //Medicine
                  String formatString(List x) {
                    String formatted = '';
                    for (var i in x) {
                      formatted += '$i, ';
                    }
                    return formatted.replaceRange(formatted.length - 2, formatted.length, '');
                  }

                  for (var i = 0; i < medicineListLength; i++) {
                    final difference = DateTime.parse(startDateList[i].toString()).difference(DateTime.parse(endDateList[i].toString())).inDays.abs();

                    final formattedMedicineTime = formatString(selectedMedicineTime[i]);

                    finalMedicineDetailsList.add({
                      "end_date": DateFormat('yyyy-MM-dd').format(endDateList[i]),
                      "med_days": difference,
                      "med_desc": medicineDescController[i].text,
                      "med_name": medicineNameController[i].text,
                      "med_time": formattedMedicineTime,
                      "med_type": medicineTypeController[i].text,
                      "start_date": DateFormat('yyyy-MM-dd').format(startDateList[i]),
                    });
                  }

                  // Treatment
                  var treatmentStartDate = DateTime.parse(pickedTreatStartDate.toString());
                  var treatmentEndDate;
                  if (selectedTreatmentDays == '7 Days') {
                    treatmentEndDate = treatmentStartDate.add(const Duration(days: 7));
                  } else if (selectedTreatmentDays == '15 Days') {
                    treatmentEndDate = treatmentStartDate.add(const Duration(days: 15));
                  } else if (selectedTreatmentDays == '20 Days') {
                    treatmentEndDate = treatmentStartDate.add(const Duration(days: 20));
                  } else if (selectedTreatmentDays == '1 Month') {
                    treatmentEndDate = treatmentStartDate.add(const Duration(days: 30));
                  } else if (selectedTreatmentDays == '3 Months') {
                    treatmentEndDate = treatmentStartDate.add(const Duration(days: 90));
                  } else {
                    if (customiseDaysMonthsYears == 'Months') {
                      treatmentEndDate = Jiffy(treatmentStartDate).add(months: int.parse(customiseController.text)).dateTime;
                    } else if (customiseDaysMonthsYears == 'Years') {
                      treatmentEndDate = Jiffy(treatmentStartDate).add(years: int.parse(customiseController.text)).dateTime;
                    } else if (customiseDaysMonthsYears == 'Days') {
                      treatmentEndDate = Jiffy(treatmentStartDate).add(days: int.parse(customiseController.text)).dateTime;
                    }
                  }

                  final finalTreatStartDate = DateFormat('yyyy-MM-dd').format(treatmentStartDate);
                  final finalTreatEndDate = DateFormat('yyyy-MM-dd').format(treatmentEndDate);

                  final treatmentDaysDiff = DateTime.parse(finalTreatStartDate).difference(DateTime.parse(finalTreatEndDate)).inDays.abs();

                  //Feedback Api call
                  final feedbackResult =
                      await docData.doctorFeedback(authData.accessToken!, bookingId, treatmentDaysDiff, finalTreatStartDate, finalTreatEndDate, diseaseController.text, finalMedicineDetailsList);

                  if (feedbackResult['status']) {
                    //Addreports api call
                    final addTreatRes = await docData.addTreatmentReports(reportTitleController.text, bookingId.toString(), selectedImage, authData.accessToken!);

                    if (addTreatRes) {
                      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
                      ShowMessages.showSnackBarMessage('Reports and Feedback added Successfully', context);
                    } else {
                      ShowMessages.showErrorDialog('Something Went wrong', context);
                    }
                  } else {
                    ShowMessages.showSnackBarMessage(feedbackResult['message'], context);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void generateTextFields() {
    medicineNameController.add(TextEditingController());
    medicineTypeController.add(TextEditingController());
    medicineDescController.add(TextEditingController());
  }

  Widget treatmentCustomiseDays(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        color: customiseDaysMonthsYears == text ? primaryColor : null,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          customiseDaysMonthsYears = text;
          setState(() {});
        },
        child: Container(
          width: 80,
          height: 30,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 2),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  Widget medicineTimeBatch(String text, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        color: selectedMedicineTime[index].contains(text) ? primaryColor : mobileBackgroundColor,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          if (selectedMedicineTime[index].contains(text)) {
            selectedMedicineTime[index].remove(text);
          } else {
            selectedMedicineTime[index].add(text);
          }
          setState(() {});
        },
        child: Container(
          width: 80,
          height: 30,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 2),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
