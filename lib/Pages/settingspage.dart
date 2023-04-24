import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  // Current theme selection
  bool isDarkModeEnabled = false;

  // Default values for VAT, service, and tip
  double defaultVat = 0.0;
  double defaultService = 0.0;
  double defaultTip = 0.0;

  void updateTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkModeEnabled', value);
    setState(() {
      isDarkModeEnabled = value;
    });
  }


  void updateVat(double vatTax) {
    setState(() {
      if(vatTax >= 0) {
        defaultVat = vatTax;
      }
    });
  }

  void updateServiceTax(double serviceTax) {
    setState(() {
      if(serviceTax >= 0) {
        defaultService = serviceTax;
      }
    });
  }

  void updateTip(double tip) {
    setState(() {
      if(tip >= 0) {
        defaultTip = tip;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkModeEnabled ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: isDarkModeEnabled ?Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkModeEnabled ? Colors.white : Colors.black,
        ),
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
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
              'Theme',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                ),
          ),
          Row(
              children: [
                Icon(
                  Icons.wb_sunny, 
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                ),
                SizedBox(width: 16),
                Switch(
                  value: isDarkModeEnabled,
                  onChanged: (value) async {
                    updateTheme(value);
                  },
                  activeColor: isDarkModeEnabled ? Colors.white : Colors.black,
                  inactiveTrackColor: Colors.grey[300],
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.nightlight_round,
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                ),
              ],
          ),
          SizedBox(height: 16.0),
          Text(
              'Default values', 
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
          SizedBox(height: 16.0),
          TextField(
            style: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'VAT (%)',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  width: 2.0,
                ),
              ),
              hintStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              labelStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              suffixText: '%',
              suffixStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) async {
              setState(() {
                updateVat(double.tryParse(value) ?? 0.0);
              });
              final prefs = await SharedPreferences.getInstance();
              prefs.setDouble('defaultVat', defaultVat);
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            style: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Service (%)',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  width: 2.0,
                ),
                
              ),
              hintStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              labelStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              suffixText: '%',
              suffixStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) async {
              setState(() {
                updateServiceTax(double.tryParse(value) ?? 0.0);
              });
              final prefs = await SharedPreferences.getInstance();
              prefs.setDouble('defaultService', defaultService);
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            style: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Tip (%)',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  width: 2.0,
                ),
              ),
              hintStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              labelStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              suffixText: '%',
              suffixStyle: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) async {
              setState(() {
                updateTip(double.tryParse(value) ?? 0.0);
              });
              final prefs = await SharedPreferences.getInstance();
              prefs.setDouble('defaultTip', defaultTip);
            },
          ),
        ],
      ),
    );
  }
}
