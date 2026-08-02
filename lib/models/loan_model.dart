class LoanModel {
  final String id;
  final String person;
  final double amount;
  final bool isBorrowed;
  final DateTime date;
  final DateTime? dueDate;
  final String note;
  final String status;
  final String? linkedTransactionId;

  LoanModel({
    required this.id,
    required this.person,
    required this.amount,
    required this.isBorrowed,
    required this.date,
    this.dueDate,
    required this.note,
    required this.status,
    this.linkedTransactionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'person': person,
      'amount': amount,
      'isBorrowed': isBorrowed ? 1 : 0,
      'date': date.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'note': note,
      'status': status,
      'linkedTransactionId': linkedTransactionId,
    };
  }

  factory LoanModel.fromMap(Map<String, dynamic> map) {
    return LoanModel(
      id: map['id'],
      person: map['person'],
      amount: map['amount'],
      isBorrowed: map['isBorrowed'] == 1,
      date: DateTime.parse(map['date']),
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'])
          : null,
      note: map['note'] ?? '',
      status: map['status'],
      linkedTransactionId: map['linkedTransactionId'],
    );
  }

  LoanModel copyWith({
    String? id,
    String? person,
    double? amount,
    bool? isBorrowed,
    DateTime? date,
    DateTime? dueDate,
    String? note,
    String? status,
    String? linkedTransactionId,
  }) {
    return LoanModel(
      id: id ?? this.id,
      person: person ?? this.person,
      amount: amount ?? this.amount,
      isBorrowed: isBorrowed ?? this.isBorrowed,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      note: note ?? this.note,
      status: status ?? this.status,
      linkedTransactionId:
      linkedTransactionId ?? this.linkedTransactionId,
    );
  }
}