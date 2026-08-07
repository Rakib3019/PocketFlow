import 'package:flutter/material.dart';

class AddLoanViewModel extends ChangeNotifier {

 /// Controllers
  final TextEditingController personController =
  TextEditingController();

  final TextEditingController amountController =
  TextEditingController();

  /// Loan Type
  bool _isBorrowed = true;

 /// Dates
  DateTime _date = DateTime.now();
  DateTime? _dueDate;

 /// Note
  String _note = "";

  /// Message
  String? _message;
  Color _messageColor = Colors.red;
  IconData _messageIcon = Icons.error_outline;

/// Getters

  bool get isBorrowed => _isBorrowed;

  DateTime get date => _date;

  DateTime? get dueDate => _dueDate;

  String get note => _note;

  double get amount =>
      double.tryParse(amountController.text) ?? 0;

  String get person =>
      personController.text.trim();

  String? get message => _message;

  Color get messageColor => _messageColor;

  IconData get messageIcon => _messageIcon;

  /// Methods

  void changeLoanType(bool value) {
    _isBorrowed = value;
    notifyListeners();
  }

  void changeDate(DateTime value) {
    _date = value;
    notifyListeners();
  }

  void changeDueDate(DateTime? value) {
    _dueDate = value;
    notifyListeners();
  }

  void changeNote(String value) {
    _note = value;
    notifyListeners();
  }

/// Messages

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

/// Reset
  
  void reset() {
    personController.clear();
    amountController.clear();

    _isBorrowed = true;

    _date = DateTime.now();

    _dueDate = null;

    _note = "";

    clearMessage();

    notifyListeners();
  }

  @override
  void dispose() {
    personController.dispose();
    amountController.dispose();
    super.dispose();
  }
}