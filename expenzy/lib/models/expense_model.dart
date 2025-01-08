import 'package:flutter/material.dart';

//input category enum
enum ExpenseCategory {
  Food,
  Transport,
  Health,
  Shopping,
  Subscription,
  Alchohol,
  Smoke,
}

//category images
final Map<ExpenseCategory, String> expenseCategoryImages = {
  ExpenseCategory.Food: "assets/images/restaurant.png",
  ExpenseCategory.Transport: "assets/images/car.png",
  ExpenseCategory.Health: "assets/images/health.png",
  ExpenseCategory.Shopping: "assets/images/bag.png",
  ExpenseCategory.Subscription: "assets/images/bill.png",
  ExpenseCategory.Alchohol: "assets/images/drink.png",
  ExpenseCategory.Smoke: "assets/images/smoke.png",
};

//category colors
final Map<ExpenseCategory, Color> expenseCategoryColors = {
  ExpenseCategory.Food: const Color(0xFFE57373),
  ExpenseCategory.Transport: const Color(0xFF81C784),
  ExpenseCategory.Health: const Color(0xFF64B5F6),
  ExpenseCategory.Shopping: const Color(0xFFFFD54F),
  ExpenseCategory.Subscription: const Color(0xFF9575CD),
  ExpenseCategory.Alchohol: const Color(0xFFFFA726),
  ExpenseCategory.Smoke: const Color(0xFF689F38),
};

class Expense {
  final int id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.category,
      required this.date,
      required this.time,
      required this.description});
  // Convert the Expense object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  // Create an Expense object from a JSON object
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      category: ExpenseCategory.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      description: json['description'],
    );
  }
}
