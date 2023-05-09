// ignore_for_file: no_leading_underscores_for_local_identifiers

class PatientDashboard {
  Data? data;
  bool? status;
  String? message;

  PatientDashboard({this.data, this.status, this.message});

  PatientDashboard.fromJson(Map<String, dynamic> json) {
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
  List<dynamic>? banner;
  List<Questions>? questions;
  Booking? booking;

  Data({this.banner, this.questions, this.booking});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["banner"] is List) {
      banner = json["banner"] ?? [];
    }
    if (json["questions"] is List) {
      questions = json["questions"] == null ? null : (json["questions"] as List).map((e) => Questions.fromJson(e)).toList();
    }
    if (json["booking"] is Map) {
      booking = json["booking"] == null ? null : Booking.fromJson(json["booking"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (banner != null) {
      _data["banner"] = banner;
    }
    if (questions != null) {
      _data["questions"] = questions?.map((e) => e.toJson()).toList();
    }
    if (booking != null) {
      _data["booking"] = booking?.toJson();
    }
    return _data;
  }
}

class Booking {
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
  dynamic schId;
  dynamic doctorId;
  int? userId;
  int? calenderId;
  dynamic doctor;
  Patient? patient;
  dynamic schedule;
  CalenderDate? calenderDate;
  dynamic feedback;
  List<dynamic>? medicines;
  List<dynamic>? report;

  Booking(
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
      this.doctor,
      this.patient,
      this.schedule,
      this.calenderDate,
      this.feedback,
      this.medicines,
      this.report});

  Booking.fromJson(Map<String, dynamic> json) {
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
    schId = json["sch_id"];
    doctorId = json["doctor_id"];
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["calender_id"] is int) {
      calenderId = json["calender_id"];
    }
    doctor = json["doctor"];
    if (json["patient"] is Map) {
      patient = json["patient"] == null ? null : Patient.fromJson(json["patient"]);
    }
    schedule = json["schedule"];
    if (json["calender_date"] is Map) {
      calenderDate = json["calender_date"] == null ? null : CalenderDate.fromJson(json["calender_date"]);
    }
    feedback = json["feedback"];
    if (json["medicines"] is List) {
      medicines = json["medicines"] ?? [];
    }
    if (json["report"] is List) {
      report = json["report"] ?? [];
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
    _data["doctor"] = doctor;
    if (patient != null) {
      _data["patient"] = patient?.toJson();
    }
    _data["schedule"] = schedule;
    if (calenderDate != null) {
      _data["calender_date"] = calenderDate?.toJson();
    }
    _data["feedback"] = feedback;
    if (medicines != null) {
      _data["medicines"] = medicines;
    }
    if (report != null) {
      _data["report"] = report;
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

class Patient {
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
  dynamic clinicId;

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
      this.clinicId});

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
    clinicId = json["clinic_id"];
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

class Questions {
  int? id;
  String? question;
  String? type;
  String? gender;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  dynamic questionId;
  List<dynamic>? subQuestion;
  List<dynamic>? answers;
  Category? category;

  Questions({this.id, this.question, this.type, this.gender, this.createdAt, this.updatedAt, this.categoryId, this.questionId, this.subQuestion, this.answers, this.category});

  Questions.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["question"] is String) {
      question = json["question"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["gender"] is String) {
      gender = json["gender"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["category_id"] is int) {
      categoryId = json["category_id"];
    }
    questionId = json["question_id"];
    if (json["sub_question"] is List) {
      subQuestion = json["sub_question"] ?? [];
    }
    if (json["answers"] is List) {
      answers = json["answers"] ?? [];
    }
    if (json["category"] is Map) {
      category = json["category"] == null ? null : Category.fromJson(json["category"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["question"] = question;
    _data["type"] = type;
    _data["gender"] = gender;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["category_id"] = categoryId;
    _data["question_id"] = questionId;
    if (subQuestion != null) {
      _data["sub_question"] = subQuestion;
    }
    if (answers != null) {
      _data["answers"] = answers;
    }
    if (category != null) {
      _data["category"] = category?.toJson();
    }
    return _data;
  }
}

class Category {
  int? id;
  String? categoryName;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.categoryName, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["category_name"] is String) {
      categoryName = json["category_name"];
    }
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
    _data["category_name"] = categoryName;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    return _data;
  }
}
