// lib/viewmodels/transaction_viewmodel.dart

import 'package:finance_planner/models/transaction.dart';
import 'package:finance_planner/services/firebase_service.dart';
import 'package:flutter/material.dart';

// ViewModel para gerenciar o estado das transações
class TransactionViewModel with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  Future<void> addTransaction(Transaction transaction) async {
    await _firebaseService.addTransaction(transaction);
    _transactions.add(transaction);
    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    _transactions = await _firebaseService.fetchTransactions();
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _firebaseService.updateTransaction(transaction);
    final index =
        _transactions.indexWhere((trans) => trans.id == transaction.id);
    _transactions[index] = transaction;
    notifyListeners();
  }
}
