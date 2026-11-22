import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String description;
  final IconData icon;
  bool isFavorite;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.icon,
    this.isFavorite = false,
  });
}