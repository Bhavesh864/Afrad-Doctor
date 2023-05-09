import 'dart:convert';
import 'dart:io';

import 'package:afrad_doctor/models/doctor_models/all_booking_list.dart';
import 'package:afrad_doctor/models/doctor_models/doctor_dashboard.dart';
import 'package:afrad_doctor/models/doctor_models/doctor_schedule_list_by_id.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorSchedules with ChangeNotifier {
  Future<DoctorDashboard> doctorDashboard(String date, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/doctor/dashboard');

    Map data = {
      "date": date,
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
      notifyListeners();
      return DoctorDashboard.fromJson(responseData);
    } else {
      notifyListeners();
      return DoctorDashboard.fromJson(responseData);
    }
  }

  Future<DoctorScheduleListById> scheduleListById(int docId, String month, String year, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/doctor/schedule-list');

    Map data = {
      "doctor_id": docId,
      "month": month,
      "year": year,
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
      return DoctorScheduleListById.fromJson(responseData);
    } else {
      return DoctorScheduleListById.fromJson(responseData);
    }
  }

  Future<AllBookingList> allBookingsOfDoctor(int docId, DateTime date, String accessToken) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/booking/all-booking');

    Map data = {
      "doctor_id": docId,
      "date": date.toString(),
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
      return AllBookingList.fromJson(responseData);
    } else {
      return AllBookingList.fromJson(responseData);
    }
  }

  Future<String> applyReshcedule(String accessToken, List<int> bookingId) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/doctor/apply-re_schedule-by-slot');

    try {
      Map data = {
        "booking_id": bookingId,
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

      return responseData['message'];
    } catch (e) {
      print(e);
      return 'Something went wrong';
    }
  }

  Future<Map> doctorFeedback(
    String accessToken,
    int bookingId,
    int treatmentDays,
    String treatmentStartDate,
    String treatmentEndDate,
    String disease,
    List medicineDataList,
  ) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/doctor/feedback');

    try {
      Map data = {
        "booking_id": bookingId,
        "is_come": "1",
        "days": treatmentDays,
        "start_date": treatmentStartDate,
        "end_date": treatmentEndDate,
        "disease": disease,
        "medicine": medicineDataList,
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
      return responseData;
    } catch (e) {
      print(e);
      return {'message': 'Something went wrong'};
    }
  }

  Future<bool> addTreatmentReports(
    String reportTitle,
    String bookingId,
    List<File> images,
    String accessToken,
  ) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/reports/add-report');

    try {
      Map<String, String> data = {
        "booking_id": bookingId,
        'name': reportTitle,
      };

      Map<String, String> headers = {
        'Host': '<calculated when request is sent>',
        'authorization': accessToken,
        'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
        'Accept': '*/*',
      };

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll(data);
      request.headers.addAll(headers);

      for (var i = 0; i < images.length; i++) {
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          images[i].path,
        );

        request.files.add(multipartFile);
      }

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();

      var jsonData = jsonDecode(respStr);
      print(jsonData);
      return jsonData['status'];
    } catch (e) {
      print(e);
      return false;
    }
  }
}
