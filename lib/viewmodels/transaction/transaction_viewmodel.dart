import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../repositories/transaction_repository.dart';
import '../../utils/transaction_filter.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository _repository = TransactionRepository();

  List<TransactionModel> _transactions = [];

  String _searchQuery = "";

  TransactionTypeFilter _typeFilter = TransactionTypeFilter.all;

  TransactionFilter _filter = TransactionFilter.thisMonth;

  /// Getters
  List<TransactionModel> get transactions => _transactions;

  String get searchQuery => _searchQuery;

  TransactionTypeFilter get typeFilter => _typeFilter;

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

  /// Transaction Type Filter

  void changeTypeFilter(TransactionTypeFilter filter) {
    _typeFilter = filter;
    notifyListeners();
  }

  /// Date Filter

  void changeFilter(TransactionFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  /// Current Month Expense (Budget Only)
  double get currentMonthExpense {
    final now = DateTime.now();

    return _transactions
        .where(
          (t) =>
      !t.isIncome &&
          t.affectsBudget &&
          t.date.month == now.month &&
          t.date.year == now.year,
    )
        .fold(
      0.0,
          (sum, t) => sum + t.amount,
    );
  }

  /// Filtered Transactions

  List<TransactionModel> get filteredTransactions {
    Iterable<TransactionModel> list = _transactions;

    // Search
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

    // Transaction Type Filter
    switch (_typeFilter) {
      case TransactionTypeFilter.all:
        break;

      case TransactionTypeFilter.income:
        list = list.where((t) => t.isIncome);
        break;

      case TransactionTypeFilter.expense:
        list = list.where((t) => !t.isIncome);
        break;
    }

    final now = DateTime.now();

    // Date Filter
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

  /// Total Money Added (All Time)
  double get totalMoneyAdded {
    return _transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  /// Current Month Money Added
  double get currentMonthMoneyAdded {
    final now = DateTime.now();

    return _transactions
        .where(
          (t) =>
      t.isIncome &&
          t.date.month == now.month &&
          t.date.year == now.year,
    )
        .fold(
      0.0,
          (sum, t) => sum + t.amount,
    );
  }
  double get totalExpense {
    return _transactions
        .where((t) => !t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get currentBalance {
    return totalMoneyAdded - totalExpense;
  }

  /// Top Expense Categories
  Map<String, double> get expenseCategoryData {
    final Map<String, double> data = {};

    for (final transaction in _transactions) {
      if (transaction.isIncome) continue;

      // Ignore loan transactions
      if (transaction.linkedLoanId != null) continue;

      data.update(
        transaction.categoryId,
            (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    return data;
  }

  ///
  List<MapEntry<String, double>> get topExpenseCategories {
    final list = expenseCategoryData.entries.toList();

    list.sort(
          (a, b) => b.value.compareTo(a.value),
    );

    return list.take(4).toList();
  }

 ///
  double get otherExpenseAmount {
    final list = expenseCategoryData.entries.toList();

    list.sort(
          (a, b) => b.value.compareTo(a.value),
    );

    if (list.length <= 4) {
      return 0;
    }

    return list
        .skip(4)
        .fold(
      0.0,
          (sum, item) => sum + item.value,
    );
  }

///

  double get totalExpenseForChart {
    return expenseCategoryData.values.fold(
      0.0,
          (sum, value) => sum + value,
    );
  }

  /// Statistics - Last 6 Months Data
  /// Money Added of the last 6 months
  List<double> get monthlyIncomeData {
    final now = DateTime.now();
    List<double> data = [];

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);

      final total = _transactions
          .where(
            (t) =>
        t.isIncome &&
            t.date.month == month.month &&
            t.date.year == month.year,
      )
          .fold<double>(
        0.0,
            (sum, t) => sum + t.amount,
      );

      data.add(total);
    }

    return data;
  }

  /// Expense (Budget Only) of the last 6 months
  /// Loan transactions are excluded because affectsBudget == false
  List<double> get monthlyExpenseData {
    final now = DateTime.now();
    List<double> data = [];

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);

      final total = _transactions
          .where(
            (t) =>
        !t.isIncome &&
            t.affectsBudget &&
            t.date.month == month.month &&
            t.date.year == month.year,
      )
          .fold<double>(
        0.0,
            (sum, t) => sum + t.amount,
      );

      data.add(total);
    }

    return data;
  }

  /// Saving = Money Added - Expense
  List<double> get monthlySavingData {
    List<double> data = [];

    for (int i = 0; i < 6; i++) {
      data.add(
        monthlyIncomeData[i] - monthlyExpenseData[i],
      );
    }

    return data;
  }


  /// Weekly Expense (Last 7 Days)

  List<double> get weeklyExpenseData {
    final now = DateTime.now();
    List<double> data = [];

    for (int i = 6; i >= 0; i--) {
      final day = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));

      final total = _transactions
          .where(
            (t) =>
        !t.isIncome &&
            t.affectsBudget &&
            t.date.year == day.year &&
            t.date.month == day.month &&
            t.date.day == day.day,
      )
          .fold<double>(
        0.0,
            (sum, t) => sum + t.amount,
      );

      data.add(total);
    }

    return data;
  }

}