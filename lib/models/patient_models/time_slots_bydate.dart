
// ignore_for_file: no_leading_underscores_for_local_identifiers

class TimeSlotsBydate {
  List<Data>? data;
  bool? status;
  String? message;

  TimeSlotsBydate({this.data, this.status, this.message});

  TimeSlotsBydate.fromJson(Map<String, dynamic> json) {
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["status"] = status;
    _data["message"] = message;
    return _data;
  }
}

class Data {
  String? startTime;
  String? endTime;

  Data({this.startTime, this.endTime});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["start_time"] is String) {
      startTime = json["start_time"];
    }
    if(json["end_time"] is String) {
      endTime = json["end_time"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["start_time"] = startTime;
    _data["end_time"] = endTime;
    return _data;
  }
}