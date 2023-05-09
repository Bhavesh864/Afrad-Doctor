import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? accessToken;
  String? userId;
  dynamic userData;
  String? otp;

  Future<String> logIn(String email, String password, String fcmToken, String type, BuildContext ctx) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/auth/login');
    try {
      Map data = {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
        'type': type,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      final jsonData = json.decode(response.body);

      if (jsonData['status'] == false) {
        return jsonData['message'];
      }

      if (jsonData['data'] != null) {
        accessToken = jsonData['data']['token'];
        userId = jsonData['data']['id'].toString();
        userData = jsonData['data'];
      }

      print(jsonData['data']['token']);
      // print(jsonData);

      final prefs = await SharedPreferences.getInstance();
      final prefData = json.encode({
        'accessToken': accessToken,
        'userId': userId,
      });
      // print('pref data -------- $prefData');
      prefs.setString('userData', prefData);

      print('json data ---------- $jsonData');
      return jsonData['message'];
    } catch (e) {
      // return e.toString();
      print(e);
      return 'Something went wrong!';
    }
  }

  Future<String> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
    String gender,
    String phone,
    String nationality,
  ) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/auth/register');
    try {
      Map data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'type': 'patient',
        'gender': gender,
        'phone': phone,
        'nationality': nationality,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      final jsonData = json.decode(response.body);
      return jsonData['message'];
    } catch (e) {
      return 'Something went wrong';
    }
  }

  Future<bool> tryAutoLogin() async {
    final res = await Future.delayed(Duration(seconds: 4), (() async {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return false;
      }

      final extractedData = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      // print('extractedData -------- $extractedData');

      accessToken = extractedData['accessToken'];
      userId = extractedData['userId'];
      userData = extractedData['userData'];

      print('user id --------- $userId');
      print(accessToken);

      try {
        final url = Uri.parse('http://168.235.81.206:7100/api/user/detail/$userId');
        final response = await http.get(
          url,
          headers: {
            'Host': '<calculated when request is sent>',
          },
        );
        final responseData = json.decode(response.body);
        // print('Data fetch from user id ------ $responseData');

        if (responseData['status'] == false) {
          return false;
        }

        if (responseData['data'] != null) {
          accessToken = responseData['data']['token'];
          userId = responseData['data']['id'].toString();
          userData = responseData['data'];
          // print(responseData['data']);
          return true;
        }
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }));

    return res;
  }

  Future<String> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    final url = Uri.parse('http://168.235.81.206:7100/api/auth/logout');
    try {
      final response = await http.get(
        url,
        headers: {
          'Host': '<calculated when request is sent>',
          'Authorization': '$accessToken',
        },
      );
      final responseData = json.decode(response.body);
      notifyListeners();
      accessToken = null;
      userId = null;
      userData = null;

      return responseData['message'];
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> forgotPassword(String email, String type) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/auth/forget-password');
    try {
      Map data = {
        'email': email,
        'type': type,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      final responseData = json.decode(response.body);
      if (responseData['data'] != null) {
        otp = responseData['data'].toString();
        print('OTP ---------- $otp');
      }
      return responseData['message'];
    } catch (e) {
      return 'Something went wrong!';
    }
  }

  Future<String> changePassword(String email, String password, String type) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/auth/change-password');
    try {
      Map data = {
        'email': email,
        'password': password,
        'type': type,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] == false) {
        return responseData['message'];
      }

      // print(responseData);
      return responseData['message'];
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> editProfile(
    File? image,
    String firstName,
    String lastName,
    String age,
    String address,
    String nationality,
    String about,
    String gender,
  ) async {
    final url = Uri.parse('http://168.235.81.206:7100/api/user/edit-profile');
    // print(userId);
    try {
      Map<String, String> data = {
        "first_name": firstName,
        "last_name": lastName,
        'age': age,
        'address': address,
        'nationality': nationality,
        'about': about,
        'gender': gender,
        'user_id': userId!,
      };

      Map<String, String> headers = {
        'Host': '<calculated when request is sent>',
        'X-Requested-With': 'XMLHttpRequest',
        'authorization': '$accessToken',
        'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
        'Accept': '*/*',
      };

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll(data);
      request.headers.addAll(headers);

      if (image != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          image.path,
        );
        request.files.add(multipartFile);
      }

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();

      var jsonData = jsonDecode(respStr);

      if (response.statusCode == 200) {
        final url = Uri.parse('http://168.235.81.206:7100/api/user/detail/$userId');
        final response = await http.get(
          url,
          headers: {
            'Host': '<calculated when request is sent>',
          },
        );
        final responseData = json.decode(response.body);
        // print('Data fetch from user id ------ $responseData');

        if (responseData['data'] != null) {
          accessToken = responseData['data']['token'];
          userId = responseData['data']['id'].toString();
          userData = responseData['data'];
          // print(responseData['data']);
        }
        notifyListeners();
        return jsonData['message'];
      } else {
        return jsonData['message'];
      }
    } catch (e) {
      print(e);
      return 'Something went wrong';
    }
  }
}
