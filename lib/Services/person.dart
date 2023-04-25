import 'package:flutter/material.dart';

class Person extends ChangeNotifier {
  late String _name;
  List<double> _items = [];
  double _total = 0.0;

  Person({required String name}) {
    _name = name;
  }
  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  List<double> getItems() {
    return _items;
  }

  double getTotal() {
    return _total;
  }
  
  void addItem() {
    _items.add(0);
  }

  void removeItem(int itemIndex) {
    _items.removeAt(itemIndex);
  }

  void calculateTotal(double vat, double serviceTax, double tip) {
    double personTotal = 0.0;
    if(_items.isNotEmpty) {
      personTotal += _items.reduce((sum, item) => sum + item);
    }
    _total = personTotal + (personTotal * vat/100) + (personTotal * serviceTax/100) + tip;
  }
}