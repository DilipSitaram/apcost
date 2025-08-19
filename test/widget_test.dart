import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apcost/main.dart';

void main() {
  testWidgets('Home screen loads with Get Started button', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const ApCostApp());

    // Verify "Get Started" button appears on Home screen
    expect(find.text('Get Started'), findsOneWidget);

    // Verify developer credit is shown on Home screen
    expect(find.text('Developed by Dilip Sitaram'), findsOneWidget);
  });
}