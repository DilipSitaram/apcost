import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/variable.dart';
import '../services/variables_store.dart';

class VariablesScreen extends StatelessWidget {
  const VariablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<VariablesStore>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Section(
          title: 'Primary variables',
          hint: 'Inputs that directly affect unit cost',
          vars: store.byType(VariableType.primary).toList(),
        ),
        const SizedBox(height: 16),
        _Section(
          title: 'Secondary variables',
          hint: 'Parameters like batch size, wastage, overhead keys',
          vars: store.byType(VariableType.secondary).toList(),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Values saved (will feed costing).')),
            );
          },
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String hint;
  final List<CostVariable> vars;
  const _Section({required this.title, required this.hint, required this.vars});

  @override
  Widget build(BuildContext context) {
    final store = context.read<VariablesStore>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(hint),
            const SizedBox(height: 12),
            for (final v in vars) ...[
              Row(
                children: [
                  Expanded(flex: 2, child: Text(v.label)),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: TextEditingController(text: v.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(offset: v.value.length),
                        ),
                      onChanged: (val) => store.updateValue(v.key, val),
                      decoration: InputDecoration(
                        labelText: v.unit == null ? 'Value' : 'Value (${v.unit})',
                        filled: true,
                        // temporary palette; we’ll swap to your Master Sheet colors next
                        fillColor: v.type == VariableType.primary
                            ? const Color(0xFFFFF8E1)  // light amber
                            : const Color(0xFFE3F2FD), // light blue
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}