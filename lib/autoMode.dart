import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AutoMode extends StatefulWidget {
  const AutoMode({super.key});

  @override
  State<AutoMode> createState() => _AutoModeState();
}

class _AutoModeState extends State<AutoMode> {
  List<List<dynamic>> _data = [];
  //var time = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    //var time = DateTime.now();
    //var time =
    //DateTime.fromMillisecondsSinceEpoch(_data[_data.length - 1][3] * 1000);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Reading: ${_data[_data.length - 1][0]}",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            "${_data[_data.length - 1][1]}",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
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
              "${_data[_data.length - 1][2]} \u2103",
              style: const TextStyle(
                fontSize: 60,
              ),
            ),
          ],
        ),
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
              "${_data[_data.length - 1][3]} %",
              style: const TextStyle(
                fontSize: 60,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
