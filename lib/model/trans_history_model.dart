// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) =>
    TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) =>
    json.encode(data.toJson());

class TransactionHistoryModel {
  String? accountNumber;
  String? accountHolder;
  List<Transaction>? transactions;

  TransactionHistoryModel({
    this.accountNumber,
    this.accountHolder,
    this.transactions,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryModel(
        accountNumber: json["account_number"],
        accountHolder: json["account_holder"],
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_holder": accountHolder,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  String? transactionId;
  DateTime? date;
  String? description;
  num? amount;
  num? balance;
  String? category;
  Location? location;

  Transaction({
    this.transactionId,
    this.date,
    this.description,
    this.amount,
    this.balance,
    this.category,
    this.location,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionId: json["transaction_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"],
        amount: json["amount"],
        balance: json["balance"],
        category: json["category"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "description": description,
        "amount": amount,
        "balance": balance,
        "category": category,
        "location": location?.toJson(),
      };
}

class Location {
  String? city;
  String? state;
  String? country;

  Location({
    this.city,
    this.state,
    this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
      };
}
