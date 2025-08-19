import 'package:flutter_test/flutter_test.dart';
import 'package:apcost/services/costing_service.dart';
import 'dummy_store.dart';

void main() {
  group('CostingService vs Excel StandardCostSheet', () {
    late DummyStore store;
    late CostingService service;

    setUp(() {
      store = DummyStore();
      service = CostingService(store);
    });

    test('Default values match Excel reference', () {
      const excelFinalCost = 5850.05;
      const excelProd1Contribution = 3906.54;
      const excelRM2 = 1417.5;
      const excelPacking = 55.99;
      const excelTransport = 470.0;

      final resultFinal = service.finalCostPerKg;

      expect(resultFinal.round(), excelFinalCost.round());
      expect(service.prod1Contribution.round(), excelProd1Contribution.round());
      expect(service.rm2Component.round(), excelRM2.round());
      final packingTotal = service.packing1 +
          service.packing2 +
          service.packing3 +
          service.packing4;
      expect(packingTotal.round(), excelPacking.round());
      expect(service.transport.round(), excelTransport.round());
    });

    test('Handles zero or missing inputs gracefully', () {
      store.setVar('rm1Cost', 0);
      store.setVar('rm1Consumption', 0);
      final resultFinal = service.finalCostPerKg;
      expect(resultFinal >= 0, true);
    });

    test('Debug: step-by-step breakdown vs Excel', () {
      const excelRM1 = 3766.4;
      const excelS1 = 292.5;
      const excelS2 = 213.2;
      const excelProd1Total = 6010.07;
      const excelProd1Contribution = 3906.54;
      const excelRM2 = 1417.5;
      const excelPacking = 55.99;
      const excelTransport = 470.0;
      const excelFinal = 5850.05;

      print("=== Step by step comparison ===");
      print("RM1: Dart ${service.rm1Cost.round()} vs Excel ${excelRM1.round()}");
      print(
          "S1: Dart ${service.solventS1Cost.round()} vs Excel ${excelS1.round()}");
      print(
          "S2: Dart ${service.solventS2Cost.round()} vs Excel ${excelS2.round()}");
      print("Total Prod1: Dart ${service.totalProd1Cost.round()} vs Excel ${excelProd1Total.round()}");
      print("Prod1 Contribution: Dart ${service.prod1Contribution.round()} vs Excel ${excelProd1Contribution.round()}");
      print("RM2: Dart ${service.rm2Component.round()} vs Excel ${excelRM2.round()}");
      print("Packing: Dart ${(service.packing1 + service.packing2 + service.packing3 + service.packing4).round()} vs Excel ${excelPacking.round()}");
      print("Transport: Dart ${service.transport.round()} vs Excel ${excelTransport.round()}");
      print("Final: Dart ${service.finalCostPerKg.round()} vs Excel ${excelFinal.round()}");
      expect(true, true);
    });
  });

  group('Regression Scenarios (Excel vs App)', () {
    late DummyStore store;
    late CostingService service;

    setUp(() {
      store = DummyStore();
      service = CostingService(store);
    });

    test('RM1 consumption +10%', () {
      final base = store.varVal('rm1Consumption');
      store.setVar('rm1Consumption', base * 1.1);
      final result = service.finalCostPerKg;
      const excelExpected = 6157.2;
      expect(result.round(), excelExpected.round());
    });

    test('S1 consumption halved', () {
      final base = store.varVal('solventS1Consumption');
      store.setVar('solventS1Consumption', base / 2);
      final result = service.finalCostPerKg;
      const excelExpected = 5755.0;
      expect(result.round(), excelExpected.round());
    });

    test('Transport cost set to 0', () {
      store.setVar('t1Cost', 0);
      final result = service.finalCostPerKg;
      const excelExpected = 5380.0;
      expect(result.round(), excelExpected.round());
    });

    test('RM1 doubled + RM2 halved', () {
      final baseRM1 = store.varVal('rm1Consumption');
      final baseRM2 = store.varVal('rm2Cost');
      store.setVar('rm1Consumption', baseRM1 * 2);
      store.setVar('rm2Cost', baseRM2 / 2);
      final result = service.finalCostPerKg;
      const excelExpected = 8212.8;
      expect(result.round(), excelExpected.round());
    });

    test('Batch size doubled', () {
      final baseBatches = store.varVal('numBatchesPerMonth');
      store.setVar('numBatchesPerMonth', baseBatches * 2);
      final result = service.finalCostPerKg;
      const excelExpected = 5538.4;
      expect(result.round(), excelExpected.round());
    });

    test('Edge case: RM1 consumption = 0 (Div#0 in Excel)', () {
      store.setVar('rm1Consumption', 0);
      final result = service.finalCostPerKg;
      // Excel gave Div#0. App should handle gracefully (>=0).
      expect(result >= 0, true);
    });
  });
}