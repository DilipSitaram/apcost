import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/variables_store.dart';

class SecondaryVariablesScreen extends StatefulWidget {
  const SecondaryVariablesScreen({super.key});

  @override
  State<SecondaryVariablesScreen> createState() => _SecondaryVariablesScreenState();
}

class _SecondaryVariablesScreenState extends State<SecondaryVariablesScreen> {
  late TextEditingController numBatchesCtrl;
  late TextEditingController s1CostCtrl;
  late TextEditingController s2CostCtrl;
  late TextEditingController s1ConsCtrl;
  late TextEditingController s2ConsCtrl;

  @override
  void initState() {
    super.initState();
    final store = VariablesStore();
    numBatchesCtrl = TextEditingController(text: store.varVal('numBatchesPerMonth').toString());
    s1CostCtrl = TextEditingController(text: store.varVal('solventS1Cost').toString());
    s2CostCtrl = TextEditingController(text: store.varVal('solventS2Cost').toString());
    s1ConsCtrl = TextEditingController(text: store.varVal('solventS1Consumption').toString());
    s2ConsCtrl = TextEditingController(text: store.varVal('solventS2Consumption').toString());
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<VariablesStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Secondary Variables'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: numBatchesCtrl,
              decoration: const InputDecoration(labelText: 'Number of batches per month'),
              keyboardType: TextInputType.number,
              onChanged: (val) => store.setVar('numBatchesPerMonth', double.tryParse(val) ?? 0.0),
            ),
            TextField(
              controller: s1CostCtrl,
              decoration: const InputDecoration(labelText: 'Solvent S1 cost (₹)'),
              keyboardType: TextInputType.number,
              onChanged: (val) => store.setVar('solventS1Cost', double.tryParse(val) ?? 0.0),
            ),
            TextField(
              controller: s2CostCtrl,
              decoration: const InputDecoration(labelText: 'Solvent S2 cost (₹)'),
              keyboardType: TextInputType.number,
              onChanged: (val) => store.setVar('solventS2Cost', double.tryParse(val) ?? 0.0),
            ),
            TextField(
              controller: s1ConsCtrl,
              decoration: const InputDecoration(labelText: 'Solvent S1 consumption (Kg)'),
              keyboardType: TextInputType.number,
              onChanged: (val) => store.setVar('solventS1Consumption', double.tryParse(val) ?? 0.0),
            ),
            TextField(
              controller: s2ConsCtrl,
              decoration: const InputDecoration(labelText: 'Solvent S2 consumption (Kg)'),
              keyboardType: TextInputType.number,
              onChanged: (val) => store.setVar('solventS2Consumption', double.tryParse(val) ?? 0.0),
            ),
            const Spacer(), // Push buttons to bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button (bottom-left)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back'),
                ),

                // Reset button (bottom-center)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () async {
                    await store.resetSecondaryToDefaults();
                    setState(() {
                      numBatchesCtrl.text = store.varVal('numBatchesPerMonth').toString();
                      s1CostCtrl.text = store.varVal('solventS1Cost').toString();
                      s2CostCtrl.text = store.varVal('solventS2Cost').toString();
                      s1ConsCtrl.text = store.varVal('solventS1Consumption').toString();
                      s2ConsCtrl.text = store.varVal('solventS2Consumption').toString();
                    });
                  },
                  child: const Text('Reset to Standard Values'),
                ),

                // Next button (bottom-right)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () => Navigator.pushNamed(context, '/costingFinal'),
                  child: const Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}