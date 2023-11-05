import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'model/trans_history_model.dart';
import 'view_models/bank_trans_vm.dart';

class BankTransactionHistoryScreen extends StatelessWidget {
  const BankTransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BankTransactionsHistoryVm transController =
        Get.put(BankTransactionsHistoryVm());

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Business Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Transaction History',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: GetBuilder(
                  init: transController,
                  builder: (transController) {
                    if (transController.transactionHistory == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return FutureBuilder(
                        future: transController.sortTransactionsByDate(
                            transController.transactionHistory!),
                        builder: (context,
                            AsyncSnapshot<List<Map<String, List<Transaction>>>>
                                snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final Map<String, List<Transaction>> map =
                                    snapshot.data![index];
                                final String key = map.keys.first;
                                final List<Transaction> transactions =
                                    map[key]!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      key,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: transactions.length,
                                      itemBuilder: (context, index) {
                                        final Transaction transaction =
                                            transactions[index];
                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(
                                              transaction.category![0],
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            transaction.description!,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            transaction.date!.toString(),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          trailing: Text(
                                            transaction.amount!.toString(),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
