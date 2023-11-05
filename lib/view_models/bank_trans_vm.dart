import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/trans_history_model.dart';

class BankTransactionsHistoryVm extends GetxController {
  @override
  void onInit() {
    super.onInit();
    readHistoryJson();
  }

  TransactionHistoryModel? _transactionHistory;
  TransactionHistoryModel? get transactionHistory => _transactionHistory;

  Future<void> readHistoryJson() async {
    final String response =
        await rootBundle.loadString('assets/json/bank_history.json');
    _transactionHistory = transactionHistoryModelFromJson(response);
    log(_transactionHistory!.toJson().toString());
    update();
  }

  Future<List<Map<String, List<Transaction>>>> sortTransactionsByDate(
      TransactionHistoryModel transactions) async {
    List<Map<String, List<Transaction>>> sortedTransactions = [];

    sortedTransactions = transactions.transactions!
        .fold<List<Map<String, List<Transaction>>>>([], (map, transaction) {
      if (map.isEmpty) {
        map.add({
          transaction.date!.toString(): [transaction]
        });
      } else {
        final Map<String, List<Transaction>> lastMap = map.last;
        final String lastKey = lastMap.keys.first;
        if (lastKey == transaction.date.toString()) {
          lastMap[lastKey]!.add(transaction);
        } else {
          map.add({
            transaction.date!.toString(): [transaction]
          });
        }
      }
      return map;
    });
    sortedTransactions.sort((a, b) {
      DateTime aDate = DateTime.parse(a.keys.first);
      DateTime bDate = DateTime.parse(b.keys.first);
      return bDate.compareTo(aDate);
      // return a.keys.first.compareTo(b.keys.first);
    }); // Game changer
    return sortedTransactions;
  }
}
