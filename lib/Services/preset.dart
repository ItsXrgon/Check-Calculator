import 'package:check_calculator/services/person.dart';
import 'package:flutter/material.dart';

class Preset extends ChangeNotifier {

  String _name = '';
  List<Person> _people = [];

  Preset({required String name, required List<Person> people}) {
    _name = name;
    _people = people;
  }

  getName() {
    return _name;
  }

  setName(String name) {
    _name = name;
  }

  getPeople() {
    return _people;
  }

  setPeople(List<Person> people) {
    _people = people;
  }

}