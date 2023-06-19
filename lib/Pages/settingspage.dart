import 'package:check_calculator/services/settingsdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  void updateTheme(bool value) async {
    Provider.of<SettingsData>(context, listen: false).updateValue(value, 'isDarkModeEnabled');
  }

  void updateTipAsPercentage(bool value) async {
    Provider.of<SettingsData>(context, listen: false).updateValue(value, 'tipAsPercentage');
  }

  void updateVat(double value) {
    if(value >= 0) {
      Provider.of<SettingsData>(context, listen: false).updateValue(value, 'defaultVat');
    }
  }

  void updateServiceTax(double value) {
    if(value >= 0) {
      Provider.of<SettingsData>(context, listen: false).updateValue(value, 'defaultService');
    }
  }

  void updateTip(double value) {
    if(value >= 0) {
      Provider.of<SettingsData>(context, listen: false).updateValue(value, 'defaultTip');
    }
  }


  @override
  Widget build(BuildContext context) {

    bool isDarkModeEnabled = Provider.of<SettingsData>(context).isDarkModeEnabled;
    bool tipAsPercentage = Provider.of<SettingsData>(context).tipAsPercentage;
    double defaultVat = Provider.of<SettingsData>(context).defaultVat;
    double defaultService = Provider.of<SettingsData>(context).defaultService;
    double defaultTip = Provider.of<SettingsData>(context).defaultTip;

    return Scaffold(
      backgroundColor: isDarkModeEnabled ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: isDarkModeEnabled ?Colors.black : Colors.grey[200],
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
              'Tip as percentage',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                ),
          ),
          Row(
              children: [
                Icon(
                  Icons.euro_symbol, 
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                ),
                SizedBox(width: 16),
                Switch(
                  value: tipAsPercentage,
                  onChanged: (value) async {
                    updateTipAsPercentage(value);
                  },
                  activeColor: isDarkModeEnabled ? Colors.white : Colors.black,
                  inactiveTrackColor: Colors.grey[300],
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.percent,
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
          TextFormField(
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
            initialValue: defaultVat > 0.0 ? defaultVat.toString() : null,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                updateVat(double.tryParse(value) ?? 0.0);
              });
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
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
            initialValue: defaultService > 0.0 ? defaultService.toString() : null,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                updateServiceTax(double.tryParse(value) ?? 0.0);
              });
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            style: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Tip',
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
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            initialValue: defaultTip > 0.0 ? defaultTip.toString() : null,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                updateTip(double.tryParse(value) ?? 0.0);
              });
            },
          ),
        ],
      ),
    );
  }
}
