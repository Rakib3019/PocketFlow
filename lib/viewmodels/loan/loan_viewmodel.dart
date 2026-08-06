import 'package:flutter/material.dart';
import 'package:pocket_mate/viewmodels/transaction/transaction_viewmodel.dart';
import 'package:uuid/uuid.dart';

import '../../models/loan_model.dart';
import '../../models/transaction_model.dart';
import '../../repositories/loan_repository.dart';
import '../../repositories/transaction_repository.dart';
import '../../utils/loan_filter.dart';

class LoanViewModel extends ChangeNotifier {
  final LoanRepository _repository = LoanRepository();
  final TransactionRepository _transactionRepository =
  TransactionRepository();

  List<LoanModel> _loans = [];

  String _searchQuery = "";

  LoanFilter _filter = LoanFilter.all;


  LoanViewModel() {
    loadLoans();
  }


  /// Database


  /// Load Loans
  Future<void> loadLoans() async {
    _loans = await _repository.getLoans();
    notifyListeners();
  }

  /// Add Loan
  Future<void> addLoan(LoanModel loan) async {
    await _repository.insertLoan(loan);

    final transaction = TransactionModel(
      id: const Uuid().v4(),
      amount: loan.amount,
      isIncome: loan.isBorrowed,
      categoryId:
      loan.isBorrowed ? "Borrowed Loan" : "Lent Money",
      paymentMethod: "Loan",
      note: loan.note,
      date: loan.date,
      createdAt: DateTime.now(),
      linkedLoanId: loan.id,
      affectsBudget: false,
    );

    await _transactionRepository.insertTransaction(
      transaction,
    );

    await loadLoans();
  }

  /// Update Loan
  Future<void> updateLoan(LoanModel loan) async {
    await _repository.updateLoan(loan);
    await loadLoans();
  }

  /// Delete Loan
  Future<void> deleteLoan(String id) async {
    /// Delete linked transaction
    await _transactionRepository
        .deleteTransactionByLoanId(id);

    /// Delete loan
    await _repository.deleteLoan(id);

    await loadLoans();
  }

  /// Loan Settlement

  /// Mark Loan as Paid
  Future<bool> markAsPaid(LoanModel loan) async {
    // Check only borrowed loans
    if (loan.isBorrowed) {
      final transactions =
      await _transactionRepository.getTransactions();

      double balance = 0;

      for (final t in transactions) {
        balance += t.isIncome ? t.amount : -t.amount;
      }

      if (balance < loan.amount) {
        return false;
      }
    }

    final updatedLoan = LoanModel(
      id: loan.id,
      person: loan.person,
      amount: loan.amount,
      isBorrowed: loan.isBorrowed,
      date: loan.date,
      dueDate: loan.dueDate,
      note: loan.note,
      status: "Paid",
      linkedTransactionId: loan.linkedTransactionId,
    );

    await _repository.updateLoan(updatedLoan);

    final repaymentTransaction = TransactionModel(
      id: const Uuid().v4(),
      amount: loan.amount,
      isIncome: !loan.isBorrowed,
      categoryId: loan.isBorrowed ? "Loan Repayment" : "Loan Received",
      paymentMethod: "Loan",
      note: "Loan Settlement",
      date: DateTime.now(),
      createdAt: DateTime.now(),
      linkedLoanId: loan.id,
      affectsBudget: false,
    );

    await _transactionRepository.insertTransaction(
      repaymentTransaction,
    );

    await loadLoans();

    return true;
  }


  /// Search


  void searchLoans(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }


  /// Filter


  LoanFilter get filter => _filter;

  void changeFilter(LoanFilter filter) {
    _filter = filter;
    notifyListeners();
  }


  /// Getters

  List<LoanModel> get loans => _loans;

  String get searchQuery => _searchQuery;

  /// Search + Filter
  List<LoanModel> get filteredLoans {
    Iterable<LoanModel> list = _loans;

    /// Search
    if (_searchQuery.isNotEmpty) {
      list = list.where((loan) {
        return loan.person
            .toLowerCase()
            .contains(_searchQuery) ||
            loan.note
                .toLowerCase()
                .contains(_searchQuery);
      });
    }

    /// Filter
    switch (_filter) {
      case LoanFilter.all:
        break;

      case LoanFilter.borrowed:
        list = list.where(
              (loan) => loan.isBorrowed,
        );
        break;

      case LoanFilter.lent:
        list = list.where(
              (loan) => !loan.isBorrowed,
        );
        break;

      case LoanFilter.active:
        list = list.where(
              (loan) => loan.status == "Active",
        );
        break;

      case LoanFilter.paid:
        list = list.where(
              (loan) => loan.status == "Paid",
        );
        break;
    }

    return list.toList();
  }


  /// Loan screen

  double get totalBorrowed {
    return _loans
        .where((loan) => loan.isBorrowed)
        .fold(
      0.0,
          (sum, loan) => sum + loan.amount,
    );
  }

  double get totalLent {
    return _loans
        .where((loan) => !loan.isBorrowed)
        .fold(
      0.0,
          (sum, loan) => sum + loan.amount,
    );
  }

  double get activeBorrowed {
    return _loans
        .where(
          (loan) =>
      loan.isBorrowed &&
          loan.status == "Active",
    )
        .fold(
      0.0,
          (sum, loan) => sum + loan.amount,
    );
  }

  double get activeLent {
    return _loans
        .where(
          (loan) =>
      !loan.isBorrowed &&
          loan.status == "Active",
    )
        .fold(
      0.0,
          (sum, loan) => sum + loan.amount,
    );
  }

  int get totalLoans => _loans.length;

  int get activeLoans =>
      _loans
          .where(
            (loan) => loan.status == "Active",
      )
          .length;

  int get paidLoans =>
      _loans
          .where(
            (loan) => loan.status == "Paid",
      )
          .length;


  /// Monthly Chart Data (Last 6 Months)

  /// Borrowed Amount of Last 6 Months
  List<double> get monthlyBorrowedData {
    final now = DateTime.now();
    List<double> data = [];

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);

      final total = _loans
          .where(
            (loan) =>
        loan.isBorrowed &&
            loan.date.month == month.month &&
            loan.date.year == month.year,
      )
          .fold<double>(
        0.0,
            (sum, loan) => sum + loan.amount,
      );

      data.add(total);
    }

    return data;
  }

  /// Lent Amount of Last 6 Months
  List<double> get monthlyLentData {
    final now = DateTime.now();
    List<double> data = [];

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);

      final total = _loans
          .where(
            (loan) =>
        !loan.isBorrowed &&
            loan.date.month == month.month &&
            loan.date.year == month.year,
      )
          .fold<double>(
        0.0,
            (sum, loan) => sum + loan.amount,
      );

      data.add(total);
    }

    return data;
  }

  /// Average Borrowed
  double get averageBorrowed {
    if (monthlyBorrowedData.isEmpty) return 0;

    return monthlyBorrowedData.reduce((a, b) => a + b) /
        monthlyBorrowedData.length;
  }

  /// Average Lent
  double get averageLent {
    if (monthlyLentData.isEmpty) return 0;

    return monthlyLentData.reduce((a, b) => a + b) /
        monthlyLentData.length;
  }
}