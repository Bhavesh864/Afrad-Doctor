import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../models/patient_models/all_doctor_list.dart';

class DoctorListDetails extends StatefulWidget {
  static const routeName = '/doctor-list-details';
  const DoctorListDetails({super.key});

  @override
  State<DoctorListDetails> createState() => _DoctorListDetailsState();
}

class _DoctorListDetailsState extends State<DoctorListDetails> {
  String selectedTab = 'About';
  List<String> infoTabsList = [
    'About',
    'Speciality',
    'Experience',
    'Qualification',
  ];

  @override
  Widget build(BuildContext context) {
    final doctorData = ModalRoute.of(context)!.settings.arguments as Data;

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: activitiesBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 3),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: doctorData.image == null
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
                        '${doctorData.userProfile!.specility}',
                        style: const TextStyle(fontSize: 12, letterSpacing: 0.8),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Other Information',
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
                                subtitle: Text('${doctorData.userProfile!.about}'),
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
          ],
        ),
      ),
    );
  }
}
