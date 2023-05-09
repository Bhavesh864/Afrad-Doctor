// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:afrad_doctor/providers/auth.dart';
import 'package:afrad_doctor/screens/app_screens/tab_bar_screen.dart';
import 'package:afrad_doctor/utils/colors.dart';
import 'package:afrad_doctor/widgets/button.dart';
import 'package:afrad_doctor/widgets/snackbars_dialogbox.dart';
import '../../providers/patient_flow_provider.dart';

class SingleSelectionExample extends StatefulWidget {
  final int bookingId;
  const SingleSelectionExample(this.bookingId, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SingleSelectionExampleState createState() => _SingleSelectionExampleState();
}

class _SingleSelectionExampleState extends State<SingleSelectionExample> {
  String? selectedValue;
  List<String> sortFilter = [
    'I want to reschedule',
    'Not interested anymore',
    'NOt find the right Provider',
    'Cancelaation Reason 04',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final slotData = Provider.of<Bookings>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    selectedValue = sortFilter[index];
                    setState(() {});
                  },
                  child: Container(
                    color: activitiesBackgroundColor,
                    child: Row(
                      children: <Widget>[
                        Radio(
                            value: sortFilter[index],
                            groupValue: selectedValue,
                            onChanged: (s) {
                              selectedValue = s;
                              setState(() {});
                            }),
                        Text(sortFilter[index]),
                      ],
                    ),
                  ),
                );
              },
              itemCount: sortFilter.length,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Button(primaryColor, 'Cancel Bookings', () async {
            if (selectedValue != null) {
              final res = await slotData.cancelBooking(
                selectedValue!,
                widget.bookingId,
                authData.accessToken!,
              );
              ShowMessages.showSnackBarMessage(res, context);
              Navigator.pushReplacementNamed(context, TabsScreen.routeName);
            }
          }),
        ],
      ),
    );
  }
}
