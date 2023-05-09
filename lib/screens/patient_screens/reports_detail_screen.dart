import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:afrad_doctor/models/patient_models/patient_all_reports.dart';
import 'package:afrad_doctor/screens/patient_screens/report_image_overviewscreen.dart';
import 'package:afrad_doctor/utils/back_icon_btn.dart';
import '../../utils/colors.dart';

class ReportsDetailScreen extends StatefulWidget {
  static const routeName = '/reports-detail-screen';
  const ReportsDetailScreen({super.key});

  @override
  State<ReportsDetailScreen> createState() => _ReportsDetailScreenState();
}

class _ReportsDetailScreenState extends State<ReportsDetailScreen> {
  List<int> savedFilesList = [];

  void saveImage(String imagePath, int index) async {
    await GallerySaver.saveImage(imagePath, albumName: 'Flutter Reports');

    setState(() {
      savedFilesList.add(index);
    });

    // ignore: use_build_context_synchronously
    ShowMessages.showSnackBarMessage('Download Successfully', context);
  }

  @override
  Widget build(BuildContext context) {
    final reportData = ModalRoute.of(context)!.settings.arguments as List<Report?>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        leading: const BackIconButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: reportData.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: scheduleDays,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => ReportImageOverviewScreen('http://168.235.81.206:7100/${reportData[index]!.path}')),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          'http://168.235.81.206:7100/${reportData[index]!.path}',
                          fit: BoxFit.cover,
                          height: 160,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Text('${reportData[index]!.name}'),
                        ),
                        InkWell(
                          onTap: () {
                            saveImage('http://168.235.81.206:7100/${reportData[index]!.path}', index);
                          },
                          child: Row(
                            children: [
                              TextButton(
                                child: Text(
                                  'Download',
                                  style: TextStyle(
                                    color: secondaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  saveImage('http://168.235.81.206:7100/${reportData[index]!.path}', index);
                                },
                              ),
                              Icon(
                                savedFilesList.contains(index) ? Icons.download_done : Icons.file_download_outlined,
                                color: secondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 240,
            ),
          ),
        ),
      ),
    );
  }
}
