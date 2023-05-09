// ignore_for_file: no_leading_underscores_for_local_identifiers

class DoctorDashboard {
  Data? data;
  bool? status;
  String? message;

  DoctorDashboard({this.data, this.status, this.message});

  DoctorDashboard.fromJson(Map<String, dynamic> json) {
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
  List<SingleDate>? singleDate;
  int? notificationCount;
  bool? userProfile;

  Data({this.banner, this.singleDate, this.notificationCount, this.userProfile});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["banner"] is List) {
      banner = json["banner"] ?? [];
    }
    if (json["single_date"] is List) {
      singleDate = json["single_date"] == null ? null : (json["single_date"] as List).map((e) => SingleDate.fromJson(e)).toList();
    }
    if (json["notification_count"] is int) {
      notificationCount = json["notification_count"];
    }
    if (json["user_profile"] is bool) {
      userProfile = json["user_profile"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (banner != null) {
      _data["banner"] = banner;
    }
    if (singleDate != null) {
      _data["single_date"] = singleDate?.map((e) => e.toJson()).toList();
    }
    _data["notification_count"] = notificationCount;
    _data["user_profile"] = userProfile;
    return _data;
  }
}

class SingleDate {
  int? id;
  String? startTime;
  String? endTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? calenderId;
  int? doctorId;
  dynamic booking;

  SingleDate({this.id, this.startTime, this.endTime, this.status, this.createdAt, this.updatedAt, this.calenderId, this.doctorId, this.booking});

  SingleDate.fromJson(Map<String, dynamic> json) {
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
