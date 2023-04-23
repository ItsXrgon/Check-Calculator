import 'package:check_calculator/Pages/settings.dart';
import 'package:flutter/material.dart';

import '../Services/person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  List<Person> people = [];
  List<TextEditingController> allTotals = [];
  TextEditingController total = TextEditingController();

  int numberOfPeople = 0;
  double vat = 0.0;
  double serviceTax = 0.0;
  double tip = 0.0;


  @override
  void initState() {
    super.initState();
    allTotals = [];
    total.text = "0";
  }

  @override
  void dispose() {
    for (int i = 0; i < allTotals.length; i++) {
      allTotals[i].dispose();
    }
    total.dispose();
    super.dispose();
  }

  void addPerson() {
    setState(() {
      numberOfPeople++;
      people.add(Person(name: 'Person $numberOfPeople', items: []));
      allTotals.add(TextEditingController());
      allTotals[allTotals.length-1].text = 0.0.toString();
      updateTotals();
    });
  }

  void removePerson(int index) {
    setState(() {
      people.removeAt(index);
      allTotals[index].dispose();
      allTotals.removeAt(index);
      numberOfPeople--;

      // Update index values of remaining TextEditingControllers
      for (int i = index; i < allTotals.length; i++) {
        allTotals[i].text = people[i].total.toStringAsFixed(2);
      }

      updateTotals();
    });
  }

  void updateName(int index, String name) {
    setState(() {
      people[index].setName(name);
    });
  }

  void addItem(int personIndex) {
    setState(() {
      people[personIndex].items.add(0);
    });
  }

  void removeItem(int personIndex, int itemIndex) {
    setState(() {
      people[personIndex].items.removeAt(itemIndex);
      updateTotals();
    });
  }

  void updateItem(int personIndex, int itemIndex, double item) {
    setState(() {
      people[personIndex].items[itemIndex] = item;
      updateTotals();
    });
  }

  void updateVat(double vat) {
    setState(() {
      this.vat = vat;
      updateTotals();
    });
  }

  void updateServiceTax(double serviceTax) {
    setState(() {
      this.serviceTax = serviceTax;
      updateTotals();
    });
  }

  void updateTip(double tip) {
    setState(() {
      this.tip = tip;
      updateTotals();
    });
  }

  void updateTotals() {
    setState(() {
      for(int i=0; i<people.length; i++) {
        people[i].calculateTotal(vat, serviceTax, tip/numberOfPeople);
        allTotals[i].text = people[i].total.toStringAsFixed(2);
      }
      getTotal();
    });
  }

  void getTotal() {
    double totalAll = 0;
    for (Person person in people) {
      totalAll += person.total;
    }
    totalAll = totalAll + (totalAll * vat/100) + (totalAll * serviceTax/100) + tip;
    total.text = totalAll.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Check Calculator'),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'VAT %',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    updateVat(double.tryParse(value) ?? 0.0);
                  },
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Service Tax %',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => updateServiceTax(double.tryParse(value) ?? 0.0),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Tip',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => updateTip(double.tryParse(value) ?? 0.0),
                ),
              ),
              SizedBox(width: 8.0),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                  labelText: 'Total',
                  border: OutlineInputBorder(),
                ),
                initialValue: null,
                controller: total,
                enabled: false,
                ),
              ),
              SizedBox(width: 4.0),
            ]
          ),
        ),
        SizedBox(height: 16.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (BuildContext context, int personIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: people[personIndex].name,
                              onChanged: (value) => updateName(personIndex, value),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Total',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: null,
                              controller: allTotals[personIndex],
                              enabled: false,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => removePerson(personIndex),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int itemIndex = 0; itemIndex < people[personIndex].items.length; itemIndex++)
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Item ${itemIndex + 1}',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    initialValue: people[personIndex].items[itemIndex].toString(),
                                    onChanged: (value) {
                                      updateItem(personIndex, itemIndex, double.tryParse(value) ?? 0.0);
                                    },
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => removeItem(personIndex, itemIndex),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text('Add item'),
                                  onPressed: () => addItem(personIndex),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPerson,
        child: Icon(Icons.add),
      ),
    );
  }

}