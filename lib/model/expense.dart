import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();
final formatter = DateFormat('y/M/d');

enum Category { food, travel, shopping, entertainment }

const categoryIcons = {
  Category.food: Icons.restaurant,
  Category.travel: Icons.airplanemode_active,
  Category.shopping: Icons.shopping_cart,
  Category.entertainment: Icons.movie,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate => formatter.format(date);
}
