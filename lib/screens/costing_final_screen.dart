import 'dart:io'; // ✅ needed for exit(0)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/variables_store.dart';
import '../services/costing_service.dart';

class CostingFinalScreen extends StatelessWidget {
  const CostingFinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<VariablesStore>(context);
    final costing = CostingService(store);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Costing & Final Product Cost'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => exit(0), // ✅ properly exits app
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Primary Variables
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Primary Variables',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      ListTile(
                          title: const Text('RM1 Cost'),
                          trailing: Text(store.varVal('rm1Cost').toString())),
                      ListTile(
                          title: const Text('RM1 Consumption'),
                          trailing: Text(
                              store.varVal('rm1Consumption').toString())),
                      ListTile(
                          title: const Text('RM2 Cost'),
                          trailing: Text(store.varVal('rm2Cost').toString())),
                      ListTile(
                          title: const Text('T1 Cost'),
                          trailing: Text(store.varVal('t1Cost').toString())),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Secondary Variables
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Secondary Variables',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      ListTile(
                          title: const Text('Num Batches'),
                          trailing:
                              Text(store.varVal('numBatchesPerMonth').toString())),
                      ListTile(
                          title: const Text('S1 Cost'),
                          trailing: Text(store.varVal('solventS1Cost').toString())),
                      ListTile(
                          title: const Text('S1 Consumption'),
                          trailing: Text(
                              store.varVal('solventS1Consumption').toString())),
                      ListTile(
                          title: const Text('S2 Cost'),
                          trailing: Text(store.varVal('solventS2Cost').toString())),
                      ListTile(
                          title: const Text('S2 Consumption'),
                          trailing: Text(
                              store.varVal('solventS2Consumption').toString())),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            // Final cost prominently displayed
            Center(
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      const Text('Final Product Cost per Kg',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Text(
                        costing.finalCostPerKg.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button (bottom-left)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () => Navigator.pop(context), // back to Secondary screen
              child: const Text('Back'),
            ),

            // Placeholder Next button (bottom-right)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                // TODO: Update later to navigate to Reports/Results screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Reports/Results screen not yet implemented')),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}