import 'package:expenses_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('No Transactions 👍'),
                Container(
                  alignment: Alignment.center,
                  height: 300,
                  child: Image.asset(
                    'assets/images/tick_sign.png',
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: FittedBox(
                      child: CircleAvatar(
                        radius: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '\$${transactions[index].price}',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transactions[index].title}',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(transactions[index].date)}',
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _deleteTransaction(transactions[index]);
                      },
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
