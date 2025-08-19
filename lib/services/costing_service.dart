import 'package:apcost/stores/variables_store.dart';

/// CostingService replicates Excel formulas from StandardCostSheet.
/// All formulas are locked and must not be changed without Master Log approval.
class CostingService {
 final dynamic store; // accept VariablesStore or DummyStore
  CostingService(this.store);

  // === Special cases ===

  /// C5: Prod1 output per month = numBatchesPerMonth * (2025 / rm1Consumption)
  double get prod1OutputPerMonth =>
      store.varVal('numBatchesPerMonth') *
      (2025 / store.varVal('rm1Consumption'));

  /// D20: Wages & Rent consumption = Prod1 output per month
  double get wagesRentConsumption => prod1OutputPerMonth;

  // === Part A: Cost workings for Prod1 ===

  double get rm1Cost =>
      store.varVal('rm1Consumption') * store.varVal('rm1Cost'); // F7
  double get solventS1Cost =>
      store.varVal('solventS1Consumption') * store.varVal('solventS1Cost'); // F8
  double get solventS2Cost =>
      store.varVal('solventS2Consumption') * store.varVal('solventS2Cost'); // F9

  double get chemical1Cost => 0.58 * 135;   // F10
  double get chemical2Cost => 0.29 * 32;    // F11
  double get fuel1Cost => 44.2 * 5.2;       // F12
  double get fuel2Cost => 0.65 * 85;        // F13
  double get fuel3Cost => 0.21 * 85;        // F14
  double get power1Cost => 16.84 * 7;       // F15
  double get overhead1Cost => 1 * 153;      // F16
  double get finance1Cost => 1 * 105.12;    // F17
  double get finance2Cost => 1 * 8.84;      // F18
  double get finance3Cost => 1 * 3.57;      // F19

  /// F20: Wages & Rent cost = E20 / D20 = 3300000 / prod1OutputPerMonth
  double get wagesRentCost => 3300000 / prod1OutputPerMonth;

  /// F21: Total Prod1 cost = SUM(F7:F20)
  double get totalProd1Cost =>
      rm1Cost +
      solventS1Cost +
      solventS2Cost +
      chemical1Cost +
      chemical2Cost +
      fuel1Cost +
      fuel2Cost +
      fuel3Cost +
      power1Cost +
      overhead1Cost +
      finance1Cost +
      finance2Cost +
      finance3Cost +
      wagesRentCost;

  // === Part B: Cost workings for Final Product (Fprod) ===

  /// F23: Prod1 contribution = F21 * D23 (constant 0.65)
  double get prod1Contribution => totalProd1Cost * 0.65;

  /// F24: RM2 = D24 * E24 = 0.35 * rm2Cost
  double get rm2Component => 0.35 * store.varVal('rm2Cost');

  /// F25–F28: Packing materials
  double get packing1 => 0.04 * 448;
  double get packing2 => 0.06 * 135.7;
  double get packing3 => 0.20 * 135.7;
  double get packing4 => 0.04 * 70;

  /// F29: Transport (T1) = D29 * E29 = 1 * t1Cost
  double get transport => store.varVal('t1Cost');

  /// Final total cost per Kg (Row 30) = Prod1 contribution + RM2 + Packing + Transport
  double get finalCostPerKg =>
      prod1Contribution +
      rm2Component +
      packing1 +
      packing2 +
      packing3 +
      packing4 +
      transport;

  /// Persist final cost into VariablesStore for Reports screen
  Future<void> saveFinalCost() async {
    await store.setVar('finalProductCostPerKg', finalCostPerKg);
  }
}