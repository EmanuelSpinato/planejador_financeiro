// lib/views/home_view.dart

import 'package:finance_planner/viewmodels/transaction_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_transaction_view.dart';
import 'edit_transaction_view.dart';

// Tela principal do aplicativo que exibe a lista de transações
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionViewModel = Provider.of<TransactionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Planejador Financeiro'),
      ),
      body: FutureBuilder(
        future: transactionViewModel.fetchTransactions(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return ListView.builder(
              itemCount: transactionViewModel.transactions.length,
              itemBuilder: (ctx, index) {
                final transaction = transactionViewModel.transactions[index];
                return ListTile(
                  title: Text(transaction.description),
                  subtitle:
                      Text('${transaction.amount} - ${transaction.category}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditTransactionView(transaction: transaction),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionView()),
          );
        },
      ),
    );
  }
}
