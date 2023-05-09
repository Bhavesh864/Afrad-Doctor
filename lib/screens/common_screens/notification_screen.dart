import 'package:afrad_doctor/utils/back_icon_btn.dart';
import 'package:afrad_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notification-screen';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text('Notifications'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 300),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text('Close all'),
                  Icon(Icons.close),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 650,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: ((context, index) {
                  return SizedBox(
                    height: 130,
                    child: Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: scheduleDays,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                        title: const Text('Profile update'),
                        subtitle: const Text('Your profile has been updated'),
                        trailing: CircleAvatar(
                          child: IconButton(onPressed: (() {}), icon: const Icon(Icons.delete_outline)),
                        ),
                        style: ListTileStyle.list,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
