import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './utils/colors.dart';
import './providers/auth.dart';
import 'package:afrad_doctor/screens/patient_screens/doctor_list_details_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/medicine_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/my_doctor_list_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/my_prescription_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/my_reports_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/mypresc_myreports_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/prescription_details_screen.dart';
import 'package:afrad_doctor/screens/patient_screens/reports_detail_screen.dart';
import 'helpers/custom_route.dart';
import 'screens/doctor_screens/add_treatment_screen.dart';
import 'screens/app_screens/splash_screen.dart';
import 'providers/patient_flow_provider.dart';
import 'providers/doctor_flow_provider.dart';
import 'screens/doctor_screens/my_schedules_screen.dart';
import 'screens/doctor_screens/patient_details_screen.dart';
import 'screens/patient_screens/appointments_screen.dart';
import 'screens/patient_screens/doctor_details_screen.dart';
import 'screens/doctor_screens/reschedul_all_screen.dart';
import 'screens/common_screens/notification_screen.dart';
import 'screens/common_screens/schedule_screen.dart';
import 'screens/app_screens/tab_bar_screen.dart';
import 'screens/common_screens/homescreen.dart';
import 'screens/auth_screens/change_password_screen.dart';
import 'screens/common_screens/profile_screen.dart';
import 'screens/common_screens/user_account_screen.dart';
import 'screens/auth_screens/otp_screen.dart';
import 'screens/auth_screens/forgot_password_screen.dart';
import 'screens/auth_screens/sign_up_screen.dart';
import 'screens/auth_screens/signin_screen.dart';
import 'screens/app_screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Bookings>(
          update: (context, authData, previous) => Bookings(authData.accessToken, authData.userId),
          create: (context) => Bookings(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DoctorSchedules(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Afrad Doctor',
            theme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'jaldi',
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                },
              ),
              scaffoldBackgroundColor: mobileBackgroundColor,
            ),

            home: FutureBuilder(
              future: authData.tryAutoLogin(),
              builder: ((context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else {
                  if (authSnapshot.data == true) {
                    return const TabsScreen();
                  } else {
                    return const WelcomeScreen();
                  }
                }
              }),
            ),
            // home: const TabsScreen(),
            routes: {
              // Auth Screens
              SignInScreen.routeName: (context) => const SignInScreen(),
              SignUpScreen.routeName: (context) => const SignUpScreen(),
              ChangePassWordScreen.routeName: (context) => const ChangePassWordScreen(),
              OtpScreen.routeName: (context) => const OtpScreen(),
              ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),

              // App Screens
              WelcomeScreen.routeName: (context) => const WelcomeScreen(),
              TabsScreen.routeName: (context) => const TabsScreen(),

              // Common
              HomeScreen.routeName: (context) => const HomeScreen(),
              ProfileScreen.routeName: (context) => const ProfileScreen(),
              NotificationScreen.routeName: (context) => const NotificationScreen(),
              ScheduleScreen.routeName: (context) => const ScheduleScreen(),
              UserAccountScreen.routeName: (context) => const UserAccountScreen(),

              // Doctor Flow
              DoctorDetailScreen.routeName: (context) => const DoctorDetailScreen(),
              ReScheduleAllScreen.routeName: (context) => const ReScheduleAllScreen(),
              AppointmentScreen.routeName: (context) => const AppointmentScreen(),
              DoctorSchedulesScreen.routeName: (context) => const DoctorSchedulesScreen(),
              AddTreatmentScreen.routeName: (context) => const AddTreatmentScreen(),

              // Patient Flow
              PatientDetailsScreen.routeName: (context) => const PatientDetailsScreen(),
              MyPrescMyReportsScreen.routeName: (context) => const MyPrescMyReportsScreen(),
              MyPrescriptionScreen.routeName: (context) => const MyPrescriptionScreen(),
              PrescriptionDetailsScreen.routeName: (context) => const PrescriptionDetailsScreen(),
              MyReportScreen.routeName: (context) => const MyReportScreen(),
              ReportsDetailScreen.routeName: (context) => const ReportsDetailScreen(),
              MedicineScreen.routeName: (context) => const MedicineScreen(),
              MyDoctorListScreen.routeName: (context) => const MyDoctorListScreen(),
              DoctorListDetails.routeName: (context) => const DoctorListDetails(),
            },
          );
        },
      ),
    );
  }
}
