import 'package:flutter/material.dart';
import 'package:trouble_brewing/constants.dart';

class GameStateProvider extends ChangeNotifier {
  int activeIndex = 0;
  List<List<Additive>> additiveContents = List.filled(6, []);

  void setActiveIndex(index) {
    activeIndex = index;
    notifyListeners();
  }

  void setAdditiveContent(additiveKey) {
    additiveContents[activeIndex] = [
      ...additiveContents[activeIndex],
      additiveKey
    ];
    if (additiveContents[activeIndex].length >= 2) {
      for (int i = 0; i < additiveContents.length; i++) {
        if (additiveContents[i].length < 2) {
          activeIndex = i;
          break;
        }
      }
    }
    notifyListeners();
  }

  void clearAdditiveContent(index) {
    additiveContents[index] = [];
    notifyListeners();
  }
}
