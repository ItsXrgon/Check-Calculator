import 'package:flutter/material.dart';

class Person extends ChangeNotifier {
  List<double> items = [];
  late String name;
  double total = 0.0;

  Person({required this.name, required this.items});

  void setName(String name) {
    name = name;
  }

  String getName() {
    return name;
  }

  double getTotal() {
    return total;
  }
  
  void calculateTotal(double vat, double serviceTax, double tip) {
    double personTotal = 0.0;
    if(items.isNotEmpty) {
      personTotal += items.reduce((sum, item) => sum + item);
    }
    total = personTotal + (personTotal * vat/100) + (personTotal * serviceTax/100) + tip;
  }
}