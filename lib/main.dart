import 'screens/costing_final_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/primary_variables_screen.dart';
import 'screens/secondary_variables_screen.dart';
import 'stores/variables_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = VariablesStore();
  await store.init(); // Load saved or default values

  runApp(
    ChangeNotifierProvider.value(
      value: store,
      child: const ApCostApp(),
    ),
  );
}

class ApCostApp extends StatelessWidget {
  const ApCostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApCost',
      debugShowCheckedModeBanner: false, // ✅ Removes the "DEBUG" banner
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F5DC), // beige
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/primary': (context) => const PrimaryVariablesScreen(),
        '/secondary': (context) => const SecondaryVariablesScreen(),
        '/costingFinal': (context) => const CostingFinalScreen(),
      },
    );
  }
}