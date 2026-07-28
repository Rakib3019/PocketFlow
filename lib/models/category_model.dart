import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final bool isExpense;
  final bool isDefault;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.isExpense,
    this.isDefault = true,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? color,
    bool? isExpense,
    bool? isDefault,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isExpense: isExpense ?? this.isExpense,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}