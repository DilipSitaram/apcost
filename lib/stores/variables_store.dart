import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VariablesStore extends ChangeNotifier {
  static final VariablesStore _instance = VariablesStore._internal();
  factory VariablesStore() => _instance;
  VariablesStore._internal();

  late SharedPreferences _prefs;

  // ===== Default values (as per StandardCostSheet) =====
  final Map<String, double> _defaultPrimary = {
    'rm1Cost': 320.0,           // Raw Material 1 cost per unit (E7)
    'rm1Consumption': 11.77,    // Raw Material 1 consumption (D7)
    'rm2Cost': 4050.0,          // Raw Material 2 cost per unit (E24)
    't1Cost': 470.0,            // Transformation cost T1 (E29)
  };

  final Map<String, double> _defaultSecondary = {
    'numBatchesPerMonth': 20.0,    // Production batches per month (C4)
    'solventS1Cost': 65.0,         // Solvent S1 cost per Kg (E8)
    'solventS1Consumption': 4.5,   // Solvent S1 consumption (D8)
    'solventS2Cost': 82.0,         // Solvent S2 cost per Kg (E9)
    'solventS2Consumption': 2.6,   // Solvent S2 consumption (D9)
  };

  final Map<String, double> _values = {};

  /// Initialize store and load persisted values or defaults
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    for (var entry in {..._defaultPrimary, ..._defaultSecondary}.entries) {
      _values[entry.key] = _prefs.getDouble(entry.key) ?? entry.value;
    }
  }

  // ===== Generic getter/setter =====
  double varVal(String key) => _values[key] ?? 0.0;

  Future<void> setVar(String key, double value) async {
    _values[key] = value;
    await _prefs.setDouble(key, value);
    notifyListeners();
  }

  // ===== Reset methods =====
  Future<void> resetPrimaryToDefaults() async {
    for (var entry in _defaultPrimary.entries) {
      _values[entry.key] = entry.value;
      await _prefs.setDouble(entry.key, entry.value);
    }
    notifyListeners();
  }

  Future<void> resetSecondaryToDefaults() async {
    for (var entry in _defaultSecondary.entries) {
      _values[entry.key] = entry.value;
      await _prefs.setDouble(entry.key, entry.value);
    }
    notifyListeners();
  }

  // ===== Specific getters for final product cost screen =====
  double get finalProductCostPerKg => _values['finalProductCostPerKg'] ?? 0.0;
  double get rm2Consumption => _values['rm2Consumption'] ?? 0.0;
  double get numBatchesPerMonth => _values['numBatchesPerMonth'] ?? 0.0;
  double get solventS1Cost => _values['solventS1Cost'] ?? 0.0;
  double get solventS2Cost => _values['solventS2Cost'] ?? 0.0;
  double get solventS1Consumption => _values['solventS1Consumption'] ?? 0.0;
  double get solventS2Consumption => _values['solventS2Consumption'] ?? 0.0;
}