import 'package:expenses_tracker/models/transaction.dart';
import 'package:expenses_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);

  List<ChartBar> get chartBars {
    double totalSpendings = 0.0;

    List<Map<String, Object>> daysList = List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double daySpendings = 0.0;

      for (var tx in _recentTransactions) {
        if (weekDay.day == tx.date.day &&
            weekDay.month == tx.date.month &&
            weekDay.year == tx.date.year) {
          daySpendings += tx.price;
        }
      }

      totalSpendings += daySpendings;

      return {
        'dayLabel': DateFormat.E().format(weekDay).substring(0, 1),
        'daySpendings': daySpendings,
      };
    });
    return List.generate(7, (index) {
      return ChartBar(daysList[index]['dayLabel'],
          daysList[index]['daySpendings'] as double, totalSpendings);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [...chartBars.reversed],
        ),
      ),
    );
  }
}
