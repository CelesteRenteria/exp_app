// To parse this JSON data, do
//
//     final entriesModel = entriesModelFromJson(jsonString);

import 'dart:convert';

EntriesModel entriesModelFromJson(String str) => EntriesModel.fromJson(json.decode(str));

String entriesModelToJson(EntriesModel data) => json.encode(data.toJson());

class EntriesModel {
    int? id;
    int year;
    int month;
    int day;
    String comment;
    double entries;

    EntriesModel({
         this.id,
        required this.year,
        required this.month,
        required this.day,
        required this.comment,
        required this.entries,
    });

    factory EntriesModel.fromJson(Map<String, dynamic> json) => EntriesModel(
        id: json["id"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        comment: json["comment"],
        entries: json["entries"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "month": month,
        "day": day,
        "comment": comment,
        "entries": entries,
    };
}
