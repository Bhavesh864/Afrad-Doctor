// ignore_for_file: no_leading_underscores_for_local_identifiers

class PatientMedicineDetails {
  Data? data;
  bool? status;
  String? message;

  PatientMedicineDetails({this.data, this.status, this.message});

  PatientMedicineDetails.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
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
      _data["data"] = data?.toJson();
    }
    _data["status"] = status;
    _data["message"] = message;
    return _data;
  }
}

class Data {
  List<Patient>? patient;

  Data({this.patient});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["patient"] is List) {
      patient = json["patient"] == null ? null : (json["patient"] as List).map((e) => Patient.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (patient != null) {
      _data["patient"] = patient?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Patient {
  int? id;
  String? startTime;
  String? endTime;
  String? status;
  String? isCome;
  String? isDoctorApply;
  dynamic reason;
  dynamic rating;
  dynamic patientFeedback;
  String? createdAt;
  String? updatedAt;
  int? schId;
  int? doctorId;
  int? userId;
  int? calenderId;
  CalenderDate? calenderDate;
  List<Medicines>? medicines;
  Feedback? feedback;
  Doctor? doctor;

  Patient(
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
      this.calenderDate,
      this.medicines,
      this.feedback,
      this.doctor});

  Patient.fromJson(Map<String, dynamic> json) {
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
    if (json["calender_date"] is Map) {
      calenderDate = json["calender_date"] == null ? null : CalenderDate.fromJson(json["calender_date"]);
    }
    if (json["medicines"] is List) {
      medicines = json["medicines"] == null ? null : (json["medicines"] as List).map((e) => Medicines.fromJson(e)).toList();
    }
    if (json["feedback"] is Map) {
      feedback = json["feedback"] == null ? null : Feedback.fromJson(json["feedback"]);
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
    if (calenderDate != null) {
      _data["calender_date"] = calenderDate?.toJson();
    }
    if (medicines != null) {
      _data["medicines"] = medicines?.map((e) => e.toJson()).toList();
    }
    if (feedback != null) {
      _data["feedback"] = feedback?.toJson();
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

class Feedback {
  int? id;
  int? noOfDays;
  String? startDate;
  String? endDate;
  String? disease;
  String? createdAt;
  String? updatedAt;
  int? bookingId;

  Feedback({this.id, this.noOfDays, this.startDate, this.endDate, this.disease, this.createdAt, this.updatedAt, this.bookingId});

  Feedback.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["no_of_days"] is int) {
      noOfDays = json["no_of_days"];
    }
    if (json["start_date"] is String) {
      startDate = json["start_date"];
    }
    if (json["end_date"] is String) {
      endDate = json["end_date"];
    }
    if (json["disease"] is String) {
      disease = json["disease"];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["no_of_days"] = noOfDays;
    _data["start_date"] = startDate;
    _data["end_date"] = endDate;
    _data["disease"] = disease;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["booking_id"] = bookingId;
    return _data;
  }
}

class Medicines {
  int? id;
  int? totalNoOfMedDays;
  String? startDate;
  String? endDate;
  String? medName;
  String? medType;
  String? medDesc;
  String? medTime;
  String? createdAt;
  String? updatedAt;
  int? bookingId;

  Medicines({this.id, this.totalNoOfMedDays, this.startDate, this.endDate, this.medName, this.medType, this.medDesc, this.medTime, this.createdAt, this.updatedAt, this.bookingId});

  Medicines.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["total_no_of_med_days"] is int) {
      totalNoOfMedDays = json["total_no_of_med_days"];
    }
    if (json["start_date"] is String) {
      startDate = json["start_date"];
    }
    if (json["end_date"] is String) {
      endDate = json["end_date"];
    }
    if (json["med_name"] is String) {
      medName = json["med_name"];
    }
    if (json["med_type"] is String) {
      medType = json["med_type"];
    }
    if (json["med_desc"] is String) {
      medDesc = json["med_desc"];
    }
    if (json["med_time"] is String) {
      medTime = json["med_time"];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["total_no_of_med_days"] = totalNoOfMedDays;
    _data["start_date"] = startDate;
    _data["end_date"] = endDate;
    _data["med_name"] = medName;
    _data["med_type"] = medType;
    _data["med_desc"] = medDesc;
    _data["med_time"] = medTime;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["booking_id"] = bookingId;
    return _data;
  }
}

class CalenderDate {
  String? date;

  CalenderDate({this.date});

  CalenderDate.fromJson(Map<String, dynamic> json) {
    if (json["date"] is String) {
      date = json["date"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    return _data;
  }
}
