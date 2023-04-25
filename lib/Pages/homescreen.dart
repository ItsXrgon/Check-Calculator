import 'package:check_calculator/Pages/settingspage.dart';
import 'package:check_calculator/services/settingsdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/services/person.dart';

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
  double vatTax = 0.0;
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
      people.add(Person(name: 'Person $numberOfPeople'));
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
        allTotals[i].text = people[i].getTotal().toStringAsFixed(2);
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
      people[personIndex].addItem();
    });
  }

  void removeItem(int personIndex, int itemIndex) {
    setState(() {
      people[personIndex].removeItem(itemIndex);
      updateTotals();
    });
  }

  void updateItem(int personIndex, int itemIndex, double item) {
    setState(() {
      if(item >= 0) {
        people[personIndex].getItems()[itemIndex] = item;
        updateTotals();
      }
    });
  }

  void updateVat(double vatTax) {
    setState(() {
      if(vatTax >= 0) {
        this.vatTax = vatTax;
        updateTotals();
      }
    });
  }

  void updateServiceTax(double serviceTax) {
    setState(() {
      if(serviceTax >= 0) {
        this.serviceTax = serviceTax;
        updateTotals();
      }
    });
  }

  void updateTip(double tip) {
    setState(() {
      if(tip >= 0) {
        this.tip = tip;
        updateTotals();
      }
    });
  }

  void updateTotals() {
    setState(() {
      for(int i=0; i<people.length; i++) {
        people[i].calculateTotal(vatTax, serviceTax, tip/numberOfPeople);
        allTotals[i].text = people[i].getTotal().toStringAsFixed(2);
      }
      getTotal();
    });
  }

  void getTotal() {
    double totalAll = 0;
    for (Person person in people) {
      totalAll += person.getTotal();
    }
    totalAll = totalAll + (totalAll * vatTax/100) + (totalAll * serviceTax/100) + tip;
    total.text = totalAll.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {

    bool isDarkModeEnabled = Provider.of<SettingsData>(context).isDarkModeEnabled;
    double vatTax = Provider.of<SettingsData>(context).defaultVat;
    double serviceTax = Provider.of<SettingsData>(context).defaultService;
    double tip = Provider.of<SettingsData>(context).defaultTip;

    return Scaffold(
      backgroundColor: isDarkModeEnabled ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
          title: Text('Check Calculator'),
          backgroundColor: isDarkModeEnabled ?Colors.black : Colors.grey[200],
          centerTitle: true,
          toolbarTextStyle: TextStyle(
            color: isDarkModeEnabled ? Colors.white : Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          titleTextStyle: TextStyle(
            color: isDarkModeEnabled ? Colors.white : Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              color: isDarkModeEnabled ? Colors.white : Colors.black,
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
                    style: TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'VAT Tax',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          width: 2.0,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                      labelText: 'VAT Tax %',
                      labelStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                      suffixText: '%',
                      suffixStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: vatTax > 0.0 ? vatTax.toString() : null,
                    onChanged: (value) {
                      updateVat(double.tryParse(value) ?? 0.0);
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Service Tax',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          width: 2.0,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                      suffixText: '%',
                      suffixStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                      labelText: 'Service Tax %',
                      labelStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                    ),
                    initialValue: serviceTax > 0.0 ? serviceTax.toString() : null,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => updateServiceTax(double.tryParse(value) ?? 0.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Tip',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                          width: 2.0,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                      labelText: 'Tip',
                      labelStyle: TextStyle(
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                    ),
                    initialValue: tip > 0.0 ? tip.toString() : null,
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
                    style: TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                    labelText: 'Total',
                    border: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                    ),
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
                                style: TextStyle(
                                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: people[personIndex].getName(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    color: isDarkModeEnabled ? Colors.white : Colors.black,
                                  ),
                                ),
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
                                style: TextStyle(
                                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Total',
                                  border: OutlineInputBorder(),
                                  disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
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
                            color: Colors.red,
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
                            for (int itemIndex = 0; itemIndex < people[personIndex].getItems().length; itemIndex++)
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Item ${itemIndex + 1}',
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: isDarkModeEnabled ? Colors.white : Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: isDarkModeEnabled ? Colors.white : Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                        hintStyle: TextStyle(
                                          color: isDarkModeEnabled ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      initialValue: null,
                                      onChanged: (value) {
                                        updateItem(personIndex, itemIndex, double.tryParse(value) ?? 0.0);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
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