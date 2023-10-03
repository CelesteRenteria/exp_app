// To parse this JSON data, do
//
//     final expensesModel = expensesModelFromJson(jsonString);

import 'dart:convert';

ExpensesModel expensesModelFromJson(String str) => ExpensesModel.fromJson(json.decode(str));

String expensesModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
    int? id;
    int link;
    int year;
    int month;
    int day;
    String comment;
    double expense;

    ExpensesModel({
        this.id,
        required this.link,
        required this.year,
        required this.month,
        required this.day,
        required this.comment,
        required this.expense,
    });

    factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"],
        link: json["link"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        comment: json["comment"],
        expense: json["expense"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "year": year,
        "month": month,
        "day": day,
        "comment": comment,
        "expense": expense,
    };
}
