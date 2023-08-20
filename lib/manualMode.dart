import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;

class ManualMode extends StatefulWidget {
  const ManualMode({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualMode> createState() => _ManualModeState();
}

class _ManualModeState extends State<ManualMode> {
  List<List<dynamic>> _data = [];
  var time = DateTime.now();
  int loop1() {
    int j = 0;
    for (int i = 0; i < _data.length; i++) {
      if (_data[i][0] == 'sensor_1') {
        j = i;
      }
    }
    return j;
  }

  int loop2() {
    int j = 0;
    for (int i = 0; i < _data.length; i++) {
      if (_data[i][0] == 'sensor_2') {
        j = i;
      }
    }
    return j;
  }

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/data.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    setState(() {
      _data = listData;
      //print(_data.length);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCSV();
  }

  String dropdownvalue = 'Sensor 1';

  // List of items in our dropdown menu
  var items = ['Sensor 1', 'Sensor 2'];
  @override
  Widget build(BuildContext context) {
    //var time = DateTime.now();
    //var time =
    // DateTime.fromMillisecondsSinceEpoch(_data[_data.length - 1][3] * 1000);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Reading: ",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
            ),
            DropdownButton(
              // Initial Value
              value: dropdownvalue,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: Colors.black,
              ),

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        if (dropdownvalue == "Sensor 1")
          Center(
            child: Text(
              "${_data[loop1()][1]} ",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
          ),
        if (dropdownvalue == "Sensor 1")
          const SizedBox(
            height: 60,
          ),
        if (dropdownvalue == "Sensor 1")
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/f2.png",
                height: 160,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "${_data[loop1()][2]} \u2103",
                style: const TextStyle(
                  fontSize: 60,
                ),
              ),
            ],
          ),
        if (dropdownvalue == "Sensor 1")
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 15,
              ),
              Image.asset(
                "assets/humid.png",
                height: 160,
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                "${_data[loop1()][3]} %",
                style: const TextStyle(
                  fontSize: 60,
                ),
              ),
            ],
          ),
        if (dropdownvalue == "Sensor 2")
          Center(
            child: Text(
              "${_data[loop2()][1]}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
          ),
        if (dropdownvalue == "Sensor 2")
          const SizedBox(
            height: 60,
          ),
        if (dropdownvalue == "Sensor 2")
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/f2.png",
                height: 160,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "${_data[loop2()][2]} \u2103",
                style: const TextStyle(
                  fontSize: 60,
                ),
              ),
            ],
          ),
        if (dropdownvalue == "Sensor 2")
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 15,
              ),
              Image.asset(
                "assets/humid.png",
                height: 160,
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                "${_data[loop2()][3]} %",
                style: const TextStyle(
                  fontSize: 60,
                ),
              ),
            ],
          ),
        //if (dropdownvalue != "Sensor 5")
        //const Center(
        //child: Text(
        // "No Data",
        // style: TextStyle(
        // fontSize: 60,
        //),
        //),
        //)
      ],
    );
  }
}
