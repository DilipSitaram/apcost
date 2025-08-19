import 'package:flutter/material.dart';

class ResultStore extends ChangeNotifier {
  double finalCostPerKg = 0;

  void setFinalCost(double value) {
    finalCostPerKg = value;
    notifyListeners();
  }

  double get finalCost => finalCostPerKg;
}
