import 'package:flutter/material.dart';

class AddTransactionViewModel extends ChangeNotifier {
  // Amount
  final TextEditingController amountController = TextEditingController();

  double get amount => double.tryParse(amountController.text) ?? 0;

  // Default Payment Method
  static const String defaultPaymentMethod = "Cash";

  // Payment Methods
  final List<String> paymentMethods = [
    "Cash",
    "Bank",
    "Card",
    "bKash",
    "Nagad",
    "Rocket",
    "Others",
  ];

  // Private Variables
  bool _isIncome = false;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  String _paymentMethod = defaultPaymentMethod;
  String _note = "";

  // Getters
  bool get isIncome => _isIncome;

  String? get selectedCategory => _selectedCategory;

  DateTime get selectedDate => _selectedDate;

  String get paymentMethod => _paymentMethod;

  String get note => _note;

  // Methods

  /// Change Transaction Type
  void changeTransactionType(bool income) {
    _isIncome = income;
    notifyListeners();
  }

  /// Select Category
  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Change Date
  void changeDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Change Payment Method
  void changePaymentMethod(String method) {
    _paymentMethod = method;
    notifyListeners();
  }

  /// Change Note
  void changeNote(String value) {
    _note = value;
    notifyListeners();
  }

  /// Reset Form
  void reset() {
    _isIncome = false;
    amountController.clear();
    _selectedCategory = null;
    _selectedDate = DateTime.now();
    _paymentMethod = defaultPaymentMethod;
    _note = "";

    notifyListeners();
  }
}