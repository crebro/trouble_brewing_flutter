import 'package:flutter/material.dart';
import 'package:trouble_brewing/constants.dart';

class GameStateProvider extends ChangeNotifier {
  int activeIndex = 0;
  List<List<Additive>> additiveContents = List.filled(12, []);

  void setActiveIndex(int index, {int sectionIndex = 0}) {
    activeIndex = sectionIndex * 6 + index;
    notifyListeners();
  }

  List<List<Additive>> getAdditiveContents(int sectionIndex) {
    return additiveContents.sublist(sectionIndex * 6, sectionIndex * 6 + 6);
  }

  void setAdditiveContent(Additive additiveKey, {int sectionIndex = 0}) {
    if (additiveContents[activeIndex].length >= 2) {
      return;
    }

    additiveContents[activeIndex] = [
      ...additiveContents[activeIndex],
      additiveKey
    ];
    if (additiveContents[activeIndex].length >= 2) {
      for (int i = sectionIndex * 6; i < sectionIndex * 6 + 6; i++) {
        if (additiveContents[i].length < 2) {
          activeIndex = i;
          break;
        }
      }
    }
    notifyListeners();
  }

  void clearAdditiveContent(int index, {int sectionIndex = 0}) {
    additiveContents[sectionIndex * 6 + index] = [];
    notifyListeners();
  }
}
