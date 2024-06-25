// lib/views/edit_transaction_view.dart

import 'package:finance_planner/models/transaction.dart';
import 'package:finance_planner/viewmodels/transaction_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Tela para editar uma transação existente
class EditTransactionView extends StatefulWidget {
  final Transaction transaction;

  EditTransactionView({required this.transaction});

  @override
  _EditTransactionViewState createState() => _EditTransactionViewState();
}

class _EditTransactionViewState extends State<EditTransactionView> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late double _amount;
  late DateTime _date;
  late String _category;

  @override
  void initState() {
    super.initState();
    _description = widget.transaction.description;
    _amount = widget.transaction.amount;
    _date = widget.transaction.date;
    _category = widget.transaction.category;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedTransaction = Transaction(
        id: widget.transaction.id,
        description: _description,
        amount: _amount,
        date: _date,
        category: _category,
      );
      Provider.of<TransactionViewModel>(context, listen: false)
          .updateTransaction(updatedTransaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _description,
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
                initialValue: _amount.toString(),
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
                child: Text('Salvar'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
