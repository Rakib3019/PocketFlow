import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionViewModel extends ChangeNotifier {

  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);

    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere(
          (transaction) => transaction.id == id,
    );

    notifyListeners();
  }

  double get totalIncome {
    return _transactions
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get balance {
    return totalIncome - totalExpense;
  }
}