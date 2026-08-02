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
    "Bkash",
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


  // Message (Error / Success)
  String? _message;
  Color _messageColor = Colors.red;
  IconData _messageIcon = Icons.error_outline;

  // Getters
  bool get isIncome => _isIncome;

  String? get selectedCategory => _selectedCategory;

  DateTime get selectedDate => _selectedDate;

  String get paymentMethod => _paymentMethod;

  String get note => _note;

  String? get message => _message;

  Color get messageColor => _messageColor;

  IconData get messageIcon => _messageIcon;

  // Transaction Type


  void changeTransactionType(bool income) {
    _isIncome = income;
    notifyListeners();
  }


  // Category


  void selectCategory(String category) {
    _selectedCategory = category;
    clearMessage();
  }

// Date
  void changeDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // Payment Method
  void changePaymentMethod(String method) {
    _paymentMethod = method;
    notifyListeners();
  }

  // Note
  void changeNote(String value) {
    _note = value;
    notifyListeners();
  }


  // Messages
  void showError(String message) {
    _message = message;
    _messageColor = Colors.red;
    _messageIcon = Icons.error_outline;
    notifyListeners();
  }

  void showSuccess(String message) {
    _message = message;
    _messageColor = Colors.green;
    _messageIcon = Icons.check_circle;
    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }


  // Reset Form
  void reset() {
    _isIncome = false;
    amountController.clear();
    _selectedCategory = null;
    _selectedDate = DateTime.now();
    _paymentMethod = defaultPaymentMethod;
    _note = "";

    _message = null;
    _messageColor = Colors.red;
    _messageIcon = Icons.error_outline;

    notifyListeners();
  }

//dispose
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
