import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/autoMode.dart';
import 'package:sensor_app/manualMode.dart';
import 'package:sensor_app/providers/switchProvider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SwitchProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Temp and Humidity',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool currSel = Provider.of<SwitchProvider>(context).currSelection;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Temp and Humidity",
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mode: ${!currSel ? "Auto" : "Manual"}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: currSel ? 1 : 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: const ['Auto', 'Manual'],
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  activeBgColors: const [
                    [Colors.blue],
                    [Colors.pink]
                  ],
                  onToggle: (index) {
                    // 0 - auto - false
                    bool value = true;
                    if (index == 0) {
                      value = false;
                    }
                    Provider.of<SwitchProvider>(context, listen: false)
                        .changeSelection(value);
                  },
                ),
              ],
            ),
            // containers
            const SizedBox(
              height: 30,
            ),

            !currSel
                ? Container(
                    margin: const EdgeInsets.all(0.8), child: const AutoMode())
                : Container(
                    margin: const EdgeInsets.all(0.8),
                    child: const ManualMode()),
          ],
        ),
      ),
    );
  }
}
