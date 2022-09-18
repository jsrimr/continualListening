import 'package:flutter/material.dart';

class Manage extends ChangeNotifier {
  String text = 'Press the button and start speaking';
  bool continueListening = false;
  int cnt = 0;

  int get counter => cnt;
  void increment() {
    cnt++;
    notifyListeners();
  }

  bool get mode {
    return continueListening;
  }

  void changeMode(mode) {
    continueListening = mode;
    notifyListeners();
  }

  void setSpeechText(String newText) {
    text = newText;
    notifyListeners();
  }

}
