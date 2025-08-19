import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/variables_store.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<VariablesStore>();

    return Scaffold(
      appBar: AppBar(title: const Text('Reports'), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Final Product Cost per Kg',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '₹${store.finalProductCostPerKg.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const Divider(height: 40),

              const Text(
                'User Input Summary:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              _buildRow('RM1 Cost (₹)', store.varVal('rm1Cost')),
              _buildRow('RM1 Consumption (Kg)', store.varVal('rm1Consumption')),
              _buildRow('RM2 Cost (₹)', store.varVal('rm2Cost')),
              _buildRow('T1 Cost (₹)', store.varVal('t1Cost')),
              _buildRow('Batches per Month', store.varVal('numBatchesPerMonth')),
              _buildRow('S1 Cost (₹)', store.varVal('solventS1Cost')),
              _buildRow('S1 Consumption (Kg)', store.varVal('solventS1Consumption')),
              _buildRow('S2 Cost (₹)', store.varVal('solventS2Cost')),
              _buildRow('S2 Consumption (Kg)', store.varVal('solventS2Consumption')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value.toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}