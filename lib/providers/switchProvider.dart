import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool currSelection = false;

  bool get currentSelection {
    return currSelection;
  }

  void changeSelection(bool changedSelection) {
    currSelection = changedSelection;
    notifyListeners();
  }
}
