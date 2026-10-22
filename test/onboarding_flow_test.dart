import 'package:aerovant/app.dart';
import 'package:aerovant/core/constants/app_strings.dart';
import 'package:aerovant/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const AerovantApp());
    await tester.pump();
  }

  testWidgets('Skip is visible on all three questions', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);
    for (int step = 0; step < 3; step++) {
      expect(find.text(AppStrings.skip), findsOneWidget);
      if (step < 2) {
        await tester.tap(find.text(AppStrings.next.toUpperCase()));
        await tester.pumpAndSettle();
      }
    }
    expect(find.text(AppStrings.build.toUpperCase()), findsOneWidget);
  });

  testWidgets('Skip lands on a home built from the defaults', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text(AppStrings.skip));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.textContaining(', Driver.'), findsOneWidget);
    expect(find.text('Your Plasma White AEROVANT is ready.'), findsOneWidget);
    expect(find.text('SPIRITED · SPORT LAUNCH'), findsOneWidget);
  });

  testWidgets('answers flow through the reveal into a personal home', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);
    await tester.enterText(find.byType(TextField), 'Isah');
    await tester.tap(find.text('Track'));
    await tester.tap(find.text(AppStrings.next.toUpperCase()));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.next.toUpperCase()));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Ion Blue'));
    await tester.pump();
    await tester.tap(find.text(AppStrings.build.toUpperCase()));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.revealTitle), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.textContaining(', Isah.'), findsOneWidget);
    expect(find.text('Your Ion Blue AEROVANT is ready.'), findsOneWidget);
    expect(find.text('FOR YOU'), findsOneWidget);
    expect(find.text('Desert Test Circuit'), findsOneWidget);
  });
}
