// ignore_for_file: no_leading_underscores_for_local_identifiers

class PatientAllReports {
  List<Data>? data;
  bool? status;
  String? message;

  PatientAllReports({this.data, this.status, this.message});

  PatientAllReports.fromJson(Map<String, dynamic> json) {
    if (json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["status"] = status;
    _data["message"] = message;
    return _data;
  }
}

class Data {
  int? id;
  String? startTime;
  String? endTime;
  String? status;
  String? isCome;
  String? isDoctorApply;
  dynamic reason;
  int? rating;
  dynamic patientFeedback;
  String? createdAt;
  String? updatedAt;
  int? schId;
  int? doctorId;
  int? userId;
  int? calenderId;
  List<Report>? report;
  Doctor? doctor;

  Data(
      {this.id,
      this.startTime,
      this.endTime,
      this.status,
      this.isCome,
      this.isDoctorApply,
      this.reason,
      this.rating,
      this.patientFeedback,
      this.createdAt,
      this.updatedAt,
      this.schId,
      this.doctorId,
      this.userId,
      this.calenderId,
      this.report,
      this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["start_time"] is String) {
      startTime = json["start_time"];
    }
    if (json["end_time"] is String) {
      endTime = json["end_time"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["is_come"] is String) {
      isCome = json["is_come"];
    }
    if (json["is_doctor_apply"] is String) {
      isDoctorApply = json["is_doctor_apply"];
    }
    reason = json["reason"];
    if (json["rating"] is int) {
      rating = json["rating"];
    }
    patientFeedback = json["patient_feedback"];
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["sch_id"] is int) {
      schId = json["sch_id"];
    }
    if (json["doctor_id"] is int) {
      doctorId = json["doctor_id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["calender_id"] is int) {
      calenderId = json["calender_id"];
    }
    if (json["report"] is List) {
      report = json["report"] == null ? null : (json["report"] as List).map((e) => Report.fromJson(e)).toList();
    }
    if (json["doctor"] is Map) {
      doctor = json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["start_time"] = startTime;
    _data["end_time"] = endTime;
    _data["status"] = status;
    _data["is_come"] = isCome;
    _data["is_doctor_apply"] = isDoctorApply;
    _data["reason"] = reason;
    _data["rating"] = rating;
    _data["patient_feedback"] = patientFeedback;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["sch_id"] = schId;
    _data["doctor_id"] = doctorId;
    _data["user_id"] = userId;
    _data["calender_id"] = calenderId;
    if (report != null) {
      _data["report"] = report?.map((e) => e.toJson()).toList();
    }
    if (doctor != null) {
      _data["doctor"] = doctor?.toJson();
    }
    return _data;
  }
}

class Doctor {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? nationality;
  String? image;
  dynamic token;
  String? fcmToken;
  String? isActivated;
  String? isLogin;
  String? isBlock;
  String? type;
  String? rating;
  String? activeLanguage;
  String? createdAt;
  String? updatedAt;
  int? clinicId;

  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phone,
      this.nationality,
      this.image,
      this.token,
      this.fcmToken,
      this.isActivated,
      this.isLogin,
      this.isBlock,
      this.type,
      this.rating,
      this.activeLanguage,
      this.createdAt,
      this.updatedAt,
      this.clinicId});

  Doctor.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if (json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["password"] is String) {
      password = json["password"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["nationality"] is String) {
      nationality = json["nationality"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    token = json["token"];
    if (json["fcm_token"] is String) {
      fcmToken = json["fcm_token"];
    }
    if (json["is_activated"] is String) {
      isActivated = json["is_activated"];
    }
    if (json["is_login"] is String) {
      isLogin = json["is_login"];
    }
    if (json["is_block"] is String) {
      isBlock = json["is_block"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["rating"] is String) {
      rating = json["rating"];
    }
    if (json["active_language"] is String) {
      activeLanguage = json["active_language"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["clinic_id"] is int) {
      clinicId = json["clinic_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["email"] = email;
    _data["password"] = password;
    _data["phone"] = phone;
    _data["nationality"] = nationality;
    _data["image"] = image;
    _data["token"] = token;
    _data["fcm_token"] = fcmToken;
    _data["is_activated"] = isActivated;
    _data["is_login"] = isLogin;
    _data["is_block"] = isBlock;
    _data["type"] = type;
    _data["rating"] = rating;
    _data["active_language"] = activeLanguage;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["clinic_id"] = clinicId;
    return _data;
  }
}

class Report {
  int? id;
  String? name;
  String? path;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? bookingId;
  int? userId;

  Report({this.id, this.name, this.path, this.type, this.createdAt, this.updatedAt, this.bookingId, this.userId});

  Report.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["path"] is String) {
      path = json["path"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["booking_id"] is int) {
      bookingId = json["booking_id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["path"] = path;
    _data["type"] = type;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["booking_id"] = bookingId;
    _data["user_id"] = userId;
    return _data;
  }
}
