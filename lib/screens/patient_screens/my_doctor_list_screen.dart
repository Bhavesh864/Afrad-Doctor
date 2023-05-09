// import 'package:afrad_doctor/models/patient_models/appointments_by_month.dart';
import 'package:afrad_doctor/models/patient_models/all_doctor_list.dart';
import 'package:afrad_doctor/screens/patient_screens/doctor_list_details_screen.dart';
import 'package:afrad_doctor/utils/colors.dart';
import 'package:afrad_doctor/widgets/empty_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import '../../providers/patient_flow_provider.dart';

class MyDoctorListScreen extends StatefulWidget {
  static const routeName = '/doctor-list';
  const MyDoctorListScreen({super.key});

  @override
  State<MyDoctorListScreen> createState() => _MyDoctorListScreenState();
}

class _MyDoctorListScreenState extends State<MyDoctorListScreen> {
  final searchController = TextEditingController();

  void doctorDetailsOverview(Data doctorData) {
    Navigator.of(context).pushNamed(DoctorListDetails.routeName, arguments: doctorData);
  }

  @override
  Widget build(BuildContext context) {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    String searchedText = searchController.text;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor List'),
        centerTitle: true,
        leading: const BackIconButton(),
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchedText = value;
                });
              },
              controller: searchController,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
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
                hintText: 'Search here...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          FutureBuilder<AllDoctorList>(
            future: slotData.allDoctorList(searchedText, authData.accessToken!),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(50),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              } else {
                if (snapshot.data!.data!.isEmpty) {
                  return searchedText.isEmpty
                      ? const EmptyScreen('Doctors', 'my_doctors')
                      : const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Text('No Search Found !'),
                          ),
                        );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: ((context, index) {
                      final docData = snapshot.data!.data![index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: scheduleDays,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: (() {
                                doctorDetailsOverview(docData);
                              }),
                              leading: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor, width: 3),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('http://168.235.81.206:7100/${docData.image}'),
                                ),
                              ),
                              title: Text('${docData.firstName} ${docData.lastName}'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
