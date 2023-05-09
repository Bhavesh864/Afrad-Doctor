import 'dart:convert';

import 'package:afrad_doctor/models/patient_models/all_doctor_list.dart';
import 'package:afrad_doctor/models/patient_models/patient_all_reports.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/patient_models/appointments_by_month.dart';
import '../models/patient_models/patient_dashboard.dart';
import '../models/patient_models/patient_medicine_details.dart';

class Bookings with ChangeNotifier {
  dynamic slotTimingsData;
  String? token;
  String? userId;
  dynamic userData;

  Bookings([this.token, this.userId]);

  Future<void> getTimeSlotByDate(String selectedDate, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/booking/time-list');

    try {
      Map data = {
        'date': selectedDate,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: json.encode(data),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      slotTimingsData = responseData;
      notifyListeners();
    } catch (e) {
      print(' $e');
    }
  }

  Future<bool> addBooking(String date, String startTime, String endTime, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/booking/booking');
    try {
      Map data = {
        'date': date,
        'start_time': startTime,
        'end_time': endTime,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: json.encode(data),
      );
      final responseData = json.decode(response.body);
      // print(responseData);
      notifyListeners();
      return responseData['status'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<AppointmentsByMonth> getAppointmentByMonth(String month, String year, String status, String id, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/patient/appointment-by-month');

    Map data = {
      "patient_id": id,
      "month": month,
      "year": year,
      "status": status,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
      body: json.encode(data),
    );

    final responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200) {
      return AppointmentsByMonth.fromJson(responseData);
    } else {
      return AppointmentsByMonth.fromJson(responseData);
    }
  }

  Future<PatientDashboard> patientDashBoard(String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/patient/dashboard');

    final response = await http.get(
      url,
      headers: {'Host': '<calculated when request is sent>', 'Authorization': accessToken},
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      return PatientDashboard.fromJson(responseData);
    } else {
      return PatientDashboard.fromJson(responseData);
    }
  }

  Future<String> applyRescheduleByPatient(String pickDate, String startTime, String endTime, int bookingId, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/patient/apply-re_schedule-by-patient');

    try {
      Map data = {
        "date": pickDate,
        "start_time": startTime,
        "end_time": endTime,
        "booking_id": '$bookingId',
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: json.encode(data),
      );

      final responseData = jsonDecode(response.body);
      return responseData['message'];
    } catch (e) {
      print(e);
      return 'Something went wrong!';
    }
  }

  Future<String> cancelBooking(String reason, int bookingId, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/booking/cancel');
    try {
      Map data = {
        "booking_id": bookingId,
        "reason": reason,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: json.encode(data),
      );

      final responseData = jsonDecode(response.body);
      return responseData['message'];
    } catch (e) {
      print(e);
      return 'Something went wrong!';
    }
  }

  Future<bool> patientFeedback(int bookingId, int doctorId, int rating, String feedback, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/booking/patient-feedback');
    try {
      Map data = {
        "booking_id": bookingId,
        "rating": rating,
        "feedback": feedback,
        "doctor_id": doctorId,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: json.encode(data),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(responseData);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<PatientMedicineDetails> patientMedicineDetails(String accessToken, String id) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/booking/patient-medicine/$id');

    final response = await http.get(url, headers: {
      'Authorization': accessToken,
    });

    final responseData = json.decode(response.body);

    print(responseData);
    if (response.statusCode == 200) {
      return PatientMedicineDetails.fromJson(responseData);
    } else {
      return PatientMedicineDetails.fromJson(responseData);
    }
  }

  Future<PatientAllReports> patientAllReports(String id) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/reports/all-report/$id');

    final response = await http.get(url);

    final responseData = json.decode(response.body);

    print(responseData);
    if (response.statusCode == 200) {
      return PatientAllReports.fromJson(responseData);
    } else {
      return PatientAllReports.fromJson(responseData);
    }
  }

  Future<AllDoctorList> allDoctorList(String inputText, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/patient/all-doctor-list');

    Map data = {
      "word": inputText,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
      body: json.encode(data),
    );

    final responseData = json.decode(response.body);

    print(responseData);
    if (response.statusCode == 200) {
      return AllDoctorList.fromJson(responseData);
    } else {
      return AllDoctorList.fromJson(responseData);
    }
  }
}
