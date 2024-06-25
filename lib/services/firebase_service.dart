import 'dart:convert';

import 'package:finance_planner/models/transaction.dart';
import 'package:http/http.dart' as http;

// Serviço para interagir com o Firebase Firestore
class FirebaseService {
  final String baseUrl =
      'https://planejador-financeiro-6f09a-default-rtdb.firebaseio.com/';

  Future<void> addTransaction(Transaction transaction) async {
    final url = Uri.parse('$baseUrl/transactions.json');
    final response = await http.post(
      url,
      body: json.encode(transaction.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add transaction');
    }
  }

  Future<List<Transaction>> fetchTransactions() async {
    final url = Uri.parse('$baseUrl/transactions.json');
    final response = await http.get(
      url,
      headers: {
        'Cache-Control': 'no-cache'
      }, // Adicionando Cache-Control: no-cache
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Transaction> loadedTransactions = [];
      extractedData.forEach((id, data) {
        loadedTransactions.add(Transaction.fromJson(data));
      });
      return loadedTransactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final url = Uri.parse('$baseUrl/transactions/${transaction.id}.json');
    final response = await http.patch(
      url,
      body: json.encode(transaction.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction');
    }
  }
}
