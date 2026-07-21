class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String iconName;
  final int colorValue;
  final bool isIncome;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.iconName,
    required this.colorValue,
    required this.isIncome,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "amount": amount,
      "category": category,
      "iconName": iconName,
      "colorValue": colorValue,
      "isIncome": isIncome,
      "date": date.toIso8601String(),
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"],
      title: json["title"],
      amount: json["amount"],
      category: json["category"],
      iconName: json["iconName"],
      colorValue: json["colorValue"],
      isIncome: json["isIncome"],
      date: DateTime.parse(json["date"]),
    );
  }
}