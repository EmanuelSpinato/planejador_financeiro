// lib/views/add_transaction_view.dart

import 'package:finance_planner/models/transaction.dart';
import 'package:finance_planner/viewmodels/transaction_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// Tela para adicionar uma nova transação
class AddTransactionView extends StatefulWidget {
  @override
  _AddTransactionViewState createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  double _amount = 0;
  DateTime _date = DateTime.now();
  String _category = 'income';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTransaction = Transaction(
        id: Uuid().v4(),
        description: _description,
        amount: _amount,
        date: _date,
        category: _category,
      );
      Provider.of<TransactionViewModel>(context, listen: false)
          .addTransaction(newTransaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              // Campos adicionais para data e categoria podem ser adicionados aqui
              ElevatedButton(
                child: Text('Adicionar'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
