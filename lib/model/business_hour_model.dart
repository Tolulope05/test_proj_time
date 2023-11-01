// To parse this JSON data, do
//
//     final businessHourModel = businessHourModelFromJson(jsonString);

import 'dart:convert';

List<BusinessHourModel> businessHourModelFromJson(String str) =>
    List<BusinessHourModel>.from(
        json.decode(str).map((x) => BusinessHourModel.fromJson(x)));

String businessHourModelToJson(List<BusinessHourModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusinessHourModel {
  String? closeHours;
  List<String>? days;
  String? guestPerHour;
  String? openHours;
  List<Timeslot>? timeslots;

  BusinessHourModel({
    this.closeHours,
    this.days,
    this.guestPerHour,
    this.openHours,
    this.timeslots,
  });

  factory BusinessHourModel.fromJson(Map<String, dynamic> json) =>
      BusinessHourModel(
        closeHours: json["close_hours"],
        days: json["days"] == null
            ? []
            : List<String>.from(json["days"]!.map((x) => x)),
        guestPerHour: json["guest_per_hour"],
        openHours: json["open_hours"],
        timeslots: json["timeslots"] == null
            ? []
            : List<Timeslot>.from(
                json["timeslots"]!.map((x) => Timeslot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "close_hours": closeHours,
        "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
        "guest_per_hour": guestPerHour,
        "open_hours": openHours,
        "timeslots": timeslots == null
            ? []
            : List<dynamic>.from(timeslots!.map((x) => x.toJson())),
      };
}

class Timeslot {
  String? scheduleName;
  List<Slot>? slots;

  Timeslot({
    this.scheduleName,
    this.slots,
  });

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
        scheduleName: json["schedule_name"],
        slots: json["slots"] == null
            ? []
            : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "schedule_name": scheduleName,
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
      };
}

class Slot {
  String? startTime;
  String? endTime;

  Slot({
    this.startTime,
    this.endTime,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
      };
}
