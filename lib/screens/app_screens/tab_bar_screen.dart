import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../common_screens/homescreen.dart';
import '../common_screens/schedule_screen.dart';
import '../common_screens/user_account_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab-screen';
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // var type;
  // var gender;
  // var authData;
  // var userData;

  final List<Widget> _pages = [
    const ScheduleScreen(),
    const HomeScreen(),
    const UserAccountScreen(),
  ];

  int _selectedPageIndex = 1;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        toolbarHeight: 5,
        elevation: 0,
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: Container(
        height: 60,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: primaryColor,
        ),
        child: BottomNavigationBar(
          unselectedItemColor: const Color.fromARGB(255, 158, 153, 153),
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          backgroundColor: primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/schedules.png',
                height: 23,
              ),
              label: 'Schedules',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home.png'),
              // icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/profile.png',
                height: 23,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
