import 'package:afrad_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../screens/patient_screens/report_image_overviewscreen.dart';
import '../snackbars_dialogbox.dart';

class MyReportsGridTiles extends StatefulWidget {
  final List reports;
  final int index;
  const MyReportsGridTiles(this.reports, this.index, {super.key});

  @override
  State<MyReportsGridTiles> createState() => _MyReportsGridTilesState();
}

class _MyReportsGridTilesState extends State<MyReportsGridTiles> {
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
    // final reportsDataList = widget.reports[widget.index];
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
                  builder: ((context) => ReportImageOverviewScreen('http://168.235.81.206:7100/${widget.reports[widget.index]['path']}')),
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
                'http://168.235.81.206:7100/${widget.reports[widget.index]['path']}',
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
                child: Text('${widget.reports[widget.index]['name']}'),
              ),
              InkWell(
                onTap: () {
                  saveImage('http://168.235.81.206:7100/${widget.reports[widget.index]['path']}', widget.index);
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
                        saveImage('http://168.235.81.206:7100/${widget.reports[widget.index]['path']}', widget.index);
                      },
                    ),
                    Icon(
                      savedFilesList.contains(widget.index) ? Icons.download_done : Icons.file_download_outlined,
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
  }
}
