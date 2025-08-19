import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apcost/stores/variables_store.dart';

class PrimaryVariablesScreen extends StatefulWidget {
  const PrimaryVariablesScreen({Key? key}) : super(key: key);

  @override
  State<PrimaryVariablesScreen> createState() => _PrimaryVariablesScreenState();
}

class _PrimaryVariablesScreenState extends State<PrimaryVariablesScreen> {
  final _formKey = GlobalKey<FormState>();

  final _rm1ConsumptionController = TextEditingController();
  final _rm1CostController = TextEditingController();
  final _rm2CostController = TextEditingController();
  final _numBatchesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final store = context.read<VariablesStore>();
    _rm1ConsumptionController.text =
        store.varVal('rm1Consumption').toString();
    _rm1CostController.text = store.varVal('rm1Cost').toString();
    _rm2CostController.text = store.varVal('rm2Cost').toString();
    _numBatchesController.text =
        store.varVal('numBatchesPerMonth').toString();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<VariablesStore>();

    return Scaffold(
      appBar: AppBar(title: const Text("Primary Variables")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ===== RM1 Consumption =====
              TextFormField(
                controller: _rm1ConsumptionController,
                decoration: const InputDecoration(
                  labelText: "RM1 Consumption (Kg)",
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Required field";
                  }
                  final num? consumption = num.tryParse(val);
                  if (consumption == null) {
                    return "Numbers only allowed";
                  }
                  if (consumption == 0) {
                    return "Invalid input: RM1 consumption cannot be 0";
                  }
                  return null;
                },
                onChanged: (val) {
                  final num? consumption = num.tryParse(val);
                  if (consumption != null && consumption > 0) {
                    store.setVar('rm1Consumption', consumption.toDouble());
                  }
                },
              ),

              // ===== RM1 Cost =====
              TextFormField(
                controller: _rm1CostController,
                decoration: const InputDecoration(
                  labelText: "RM1 Cost (₹/Kg)",
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required field";
                  if (num.tryParse(val) == null) return "Numbers only allowed";
                  return null;
                },
                onChanged: (val) {
                  final num? cost = num.tryParse(val);
                  if (cost != null) {
                    store.setVar('rm1Cost', cost.toDouble());
                  }
                },
              ),

              // ===== RM2 Cost =====
              TextFormField(
                controller: _rm2CostController,
                decoration: const InputDecoration(
                  labelText: "RM2 Cost (₹/Kg)",
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required field";
                  if (num.tryParse(val) == null) return "Numbers only allowed";
                  return null;
                },
                onChanged: (val) {
                  final num? cost = num.tryParse(val);
                  if (cost != null) {
                    store.setVar('rm2Cost', cost.toDouble());
                  }
                },
              ),

              // ===== Number of Batches =====
              TextFormField(
                controller: _numBatchesController,
                decoration: const InputDecoration(
                  labelText: "Number of Batches per Month",
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required field";
                  if (num.tryParse(val) == null) return "Numbers only allowed";
                  return null;
                },
                onChanged: (val) {
                  final num? numBatches = num.tryParse(val);
                  if (numBatches != null) {
                    store.setVar('numBatchesPerMonth', numBatches.toDouble());
                  }
                },
              ),

              const SizedBox(height: 20),

              // ===== Navigation Buttons =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pushNamed(context, '/secondary');
                      }
                    },
                    child: const Text("Next"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Exit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}