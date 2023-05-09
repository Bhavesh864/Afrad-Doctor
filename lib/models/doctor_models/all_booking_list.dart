// ignore_for_file: no_leading_underscores_for_local_identifiers

class AllBookingList {
  List<Data>? data;
  bool? status;
  String? message;

  AllBookingList({this.data, this.status, this.message});

  AllBookingList.fromJson(Map<String, dynamic> json) {
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
  String? reason;
  dynamic rating;
  dynamic patientFeedback;
  String? createdAt;
  String? updatedAt;
  int? schId;
  int? doctorId;
  int? userId;
  int? calenderId;
  Patient? patient;
  Doctor? doctor;
  CalenderDate? calenderDate;

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
      this.patient,
      this.doctor,
      this.calenderDate});

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
    if (json["reason"] is String) {
      reason = json["reason"];
    }
    rating = json["rating"];
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
    if (json["patient"] is Map) {
      patient = json["patient"] == null ? null : Patient.fromJson(json["patient"]);
    }
    if (json["doctor"] is Map) {
      doctor = json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]);
    }
    if (json["calender_date"] is Map) {
      calenderDate = json["calender_date"] == null ? null : CalenderDate.fromJson(json["calender_date"]);
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
    if (patient != null) {
      _data["patient"] = patient?.toJson();
    }
    if (doctor != null) {
      _data["doctor"] = doctor?.toJson();
    }
    if (calenderDate != null) {
      _data["calender_date"] = calenderDate?.toJson();
    }
    return _data;
  }
}

class CalenderDate {
  int? id;
  String? date;
  int? year;
  int? month;
  String? isHoliday;
  dynamic reason;
  String? createdAt;
  String? updatedAt;

  CalenderDate({this.id, this.date, this.year, this.month, this.isHoliday, this.reason, this.createdAt, this.updatedAt});

  CalenderDate.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["year"] is int) {
      year = json["year"];
    }
    if (json["month"] is int) {
      month = json["month"];
    }
    if (json["is_holiday"] is String) {
      isHoliday = json["is_holiday"];
    }
    reason = json["reason"];
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["date"] = date;
    _data["year"] = year;
    _data["month"] = month;
    _data["is_holiday"] = isHoliday;
    _data["reason"] = reason;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
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
  dynamic image;
  String? token;
  String? fcmToken;
  String? isActivated;
  String? isLogin;
  String? isBlock;
  String? type;
  dynamic rating;
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
    image = json["image"];
    if (json["token"] is String) {
      token = json["token"];
    }
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
    rating = json["rating"];
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

class Patient {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? nationality;
  dynamic image;
  dynamic token;
  String? fcmToken;
  String? isActivated;
  String? isLogin;
  String? isBlock;
  String? type;
  dynamic rating;
  String? activeLanguage;
  String? createdAt;
  String? updatedAt;
  dynamic clinicId;
  UserProfile? userProfile;
  List<dynamic>? userAnswers;

  Patient(
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
      this.clinicId,
      this.userProfile,
      this.userAnswers});

  Patient.fromJson(Map<String, dynamic> json) {
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
    image = json["image"];
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
    rating = json["rating"];
    if (json["active_language"] is String) {
      activeLanguage = json["active_language"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    clinicId = json["clinic_id"];
    if (json["user_profile"] is Map) {
      userProfile = json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]);
    }
    if (json["user_answers"] is List) {
      userAnswers = json["user_answers"] ?? [];
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
    if (userProfile != null) {
      _data["user_profile"] = userProfile?.toJson();
    }
    if (userAnswers != null) {
      _data["user_answers"] = userAnswers;
    }
    return _data;
  }
}

class UserProfile {
  int? id;
  int? age;
  String? gender;
  String? address;
  dynamic specility;
  dynamic experience;
  dynamic qualification;
  String? about;
  String? createdAt;
  String? updatedAt;
  int? userId;

  UserProfile({this.id, this.age, this.gender, this.address, this.specility, this.experience, this.qualification, this.about, this.createdAt, this.updatedAt, this.userId});

  UserProfile.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["age"] is int) {
      age = json["age"];
    }
    if (json["gender"] is String) {
      gender = json["gender"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    specility = json["specility"];
    experience = json["experience"];
    qualification = json["qualification"];
    if (json["about"] is String) {
      about = json["about"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["age"] = age;
    _data["gender"] = gender;
    _data["address"] = address;
    _data["specility"] = specility;
    _data["experience"] = experience;
    _data["qualification"] = qualification;
    _data["about"] = about;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["user_id"] = userId;
    return _data;
  }
}
