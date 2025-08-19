/// DummyStore provides fixed values for unit testing CostingService.
/// It avoids SharedPreferences and ensures tests run without plugins.
class DummyStore {
  final Map<String, double> _dummyValues = {
    'rm1Cost': 320.0,
    'rm1Consumption': 11.77,
    'rm2Cost': 4050.0,
    't1Cost': 470.0,
    'numBatchesPerMonth': 20.0,
    'solventS1Cost': 65.0,
    'solventS1Consumption': 4.5,
    'solventS2Cost': 82.0,
    'solventS2Consumption': 2.6,
  };

  double varVal(String key) => _dummyValues[key] ?? 0.0;

  /// Allow overriding values for specific tests
  void setVar(String key, double value) {
    _dummyValues[key] = value;
  }
}