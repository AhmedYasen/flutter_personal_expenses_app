import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTranaction;

  NewTransaction(this._addNewTranaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final title = TextEditingController();

  final price = TextEditingController();

  DateTime? _pickedDate;

  void _submitTransaction() {
    final _title = this.title.text;
    final _price =
        this.price.text.isEmpty ? 0.00 : double.parse(this.price.text);

    if (_title.isEmpty) {
      return;
    }

    widget._addNewTranaction(
      _title,
      _price,
      _pickedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 8),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 8),
      ),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Ex. Vegitables',
                labelStyle: Theme.of(context).textTheme.bodyText2),
            autofocus: true,
            controller: title,
            onSubmitted: (_) => _submitTransaction(),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Price',
                hintText: 'Ex. 29.55',
                labelStyle: Theme.of(context).textTheme.bodyText2),
            controller: price,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitTransaction(),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: _pickedDate != null
                      ? Text(
                          'Picked Date: ${DateFormat.yMMMd().format(_pickedDate!)}')
                      : Text('No Date Selected !'),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text('Select Date'),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: _submitTransaction,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Insert',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
