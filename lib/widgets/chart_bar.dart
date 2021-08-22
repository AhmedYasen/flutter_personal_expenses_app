import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalSpendings;
  final dayLabel;
  final double daySpendings;
  ChartBar(this.dayLabel, this.daySpendings, this.totalSpendings);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            FittedBox(child: Text('\$${daySpendings.toStringAsFixed(0)}')),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 100,
              width: 12,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    heightFactor: totalSpendings <= 0
                        ? 0.0
                        : (daySpendings / totalSpendings),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(dayLabel),
          ],
        ),
      ),
    );
  }
}
