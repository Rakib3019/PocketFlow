import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../repositories/transaction_repository.dart';
import '../utils/transaction_filter.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository _repository = TransactionRepository();

  List<TransactionModel> _transactions = [];

  String _searchQuery = "";

  TransactionFilter _filter = TransactionFilter.thisMonth;

  /// Getters
  List<TransactionModel> get transactions => _transactions;

  String get searchQuery => _searchQuery;

  TransactionFilter get filter => _filter;

  TransactionViewModel() {
    loadTransactions();
  }


  /// Database
  Future<void> loadTransactions() async {
    _transactions = await _repository.getTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _repository.insertTransaction(transaction);
    await loadTransactions();
  }

  Future<void> deleteTransaction(String id) async {
    await _repository.deleteTransaction(id);
    await loadTransactions();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await _repository.updateTransaction(transaction);
    await loadTransactions();
  }


  /// Search
  void searchTransactions(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }


  /// Filter
  void changeFilter(TransactionFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  List<TransactionModel> get filteredTransactions {
    Iterable<TransactionModel> list = _transactions;

/// Search
    if (_searchQuery.isNotEmpty) {
      list = list.where((transaction) {
        return transaction.categoryId
            .toLowerCase()
            .contains(_searchQuery) ||
            transaction.paymentMethod
                .toLowerCase()
                .contains(_searchQuery) ||
            transaction.note
                .toLowerCase()
                .contains(_searchQuery);
      });
    }

    final now = DateTime.now();

    switch (_filter) {
      case TransactionFilter.thisWeek:
        final startOfWeek = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: now.weekday - 1));

        list = list.where(
              (t) =>
          !t.date.isBefore(startOfWeek) &&
              !t.date.isAfter(now),
        );
        break;

      case TransactionFilter.thisMonth:
        list = list.where(
              (t) =>
          t.date.year == now.year &&
              t.date.month == now.month,
        );
        break;

      case TransactionFilter.thisYear:
        list = list.where(
              (t) => t.date.year == now.year,
        );
        break;
    }

    return list.toList();
  }

 /// Dashboard
  List<TransactionModel> get recentTransactions {
    return _transactions.take(5).toList();
  }

  double get totalMoneyAdded {
    return _transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => !t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get currentBalance {
    return totalMoneyAdded - totalExpense;
  }
}