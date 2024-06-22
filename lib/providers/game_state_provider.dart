import 'package:flutter/material.dart';

class GameStateProvider extends ChangeNotifier {
  List<double> progresses = List.filled(12, 0.0);

  void setProgressItem(index, progress) {
    progresses[index] = progress;
    notifyListeners();
  }
}
