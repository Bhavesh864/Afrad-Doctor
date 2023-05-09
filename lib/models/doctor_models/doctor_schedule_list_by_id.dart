// ignore_for_file: no_leading_underscores_for_local_identifiers

class DoctorScheduleListById {
  List<Data>? data;
  bool? status;
  String? message;

  DoctorScheduleListById({this.data, this.status, this.message});

  DoctorScheduleListById.fromJson(Map<String, dynamic> json) {
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
  String? date;
  int? year;
  int? month;
  String? isHoliday;
  dynamic reason;
  String? createdAt;
  String? updatedAt;
  List<Schedules>? schedules;

  Data({this.id, this.date, this.year, this.month, this.isHoliday, this.reason, this.createdAt, this.updatedAt, this.schedules});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json["schedules"] is List) {
      schedules = json["schedules"] == null ? null : (json["schedules"] as List).map((e) => Schedules.fromJson(e)).toList();
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
    if (schedules != null) {
      _data["schedules"] = schedules?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Schedules {
  int? id;
  String? startTime;
  String? endTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? calenderId;
  int? doctorId;
  dynamic booking;

  Schedules({this.id, this.startTime, this.endTime, this.status, this.createdAt, this.updatedAt, this.calenderId, this.doctorId, this.booking});

  Schedules.fromJson(Map<String, dynamic> json) {
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
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["calender_id"] is int) {
      calenderId = json["calender_id"];
    }
    if (json["doctor_id"] is int) {
      doctorId = json["doctor_id"];
    }
    booking = json["booking"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["start_time"] = startTime;
    _data["end_time"] = endTime;
    _data["status"] = status;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["calender_id"] = calenderId;
    _data["doctor_id"] = doctorId;
    _data["booking"] = booking;
    return _data;
  }
}
