import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/utils/colors.dart';
import 'package:afrad_doctor/widgets/patient_widgets/my_reports_grid_tiles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyPrescMyReportsScreen extends StatefulWidget {
  static const routeName = '/mypres-myreports';
  const MyPrescMyReportsScreen({super.key});

  @override
  State<MyPrescMyReportsScreen> createState() => _MyPrescMyReportsScreenState();
}

class _MyPrescMyReportsScreenState extends State<MyPrescMyReportsScreen> {
  String selectedTab = 'My Prescription';

  @override
  Widget build(BuildContext context) {
    final dataArgs = ModalRoute.of(context)!.settings.arguments as Map<String, List<dynamic>?>;

    final medicineData = dataArgs['medicineList'];
    final reportsData = dataArgs['reportList'];

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text('Fever'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedTab = 'My Prescription';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedTab == 'My Prescription' ? primaryColor : activitiesBackgroundColor,
                    ),
                    child: const Text(
                      'My Prescription',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedTab = 'My Reports';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedTab == 'My Reports' ? primaryColor : activitiesBackgroundColor,
                    ),
                    child: const Text(
                      'My Reports',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            selectedTab == 'My Prescription'
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: medicineData!.length,
                    itemBuilder: (context, i) {
                      var startDate = DateFormat('dd-MMMM').format(DateTime.parse(medicineData[i]['start_date']));
                      var endDate = DateFormat('dd-MMMM').format(DateTime.parse(medicineData[i]['end_date']));
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
                                title: Text(medicineData[i]['med_name']),
                                subtitle: Text(medicineData[i]['med_type']),
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
                                        Text(medicineData[i]['total_no_of_med_days'].toString()),
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
                                        child: Text(medicineData[i]['med_time'])),
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
                                      child: Text(medicineData[i]['med_desc']),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : reportsData!.isNotEmpty
                    ? SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          itemCount: reportsData.length,
                          itemBuilder: (context, index) {
                            return MyReportsGridTiles(reportsData, index);
                          },
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 240,
                          ),
                        ),
                      )
                    : const SizedBox(
                        child: Text("No Reports Available !"),
                      ),
          ],
        ),
      ),
    );
  }
}
