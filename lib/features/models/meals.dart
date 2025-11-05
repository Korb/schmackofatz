import 'package:flutter/material.dart';

class Meal {
  final String title;
  final String subheadline;
  final String price1;
  final String type;
  final Icon icon;

  const Meal({
    required this.title,
    required this.subheadline,
    required this.price1,
    required this.type,
    required this.icon,
  });
}
