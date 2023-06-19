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

  static fromJson(String preset) {
    return Preset(
      name: preset.split('!')[0],
      people: preset.split('!')[1].split(';').map((person) => Person.fromJson(person)).toList() as List<Person>,
    );
  }

  toJson() {
    return '$_name!${_people.map((person) => person.toJson()).join(';')}';
  }
}