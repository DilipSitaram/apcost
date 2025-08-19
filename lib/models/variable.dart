enum VariableType { primary, secondary }

class CostVariable {
  String key;       // e.g. RM1_cost
  String label;     // e.g. RM1 cost
  String value;     // keep as string; parse when calculating
  VariableType type;
  String? unit;     // e.g. kg, ₹, %

  CostVariable({
    required this.key,
    required this.label,
    this.value = '',
    required this.type,
    this.unit,
  });
}