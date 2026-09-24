import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:randomuser/ui/custom_widget/custom_widget.dart';

void main() {
  Future<void> pumpCard(WidgetTester tester, {String? userName}) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomUserCard(urlImage: null, userName: userName),
        ),
      ),
    );
  }

  testWidgets('shows the username', (tester) async {
    await pumpCard(tester, userName: 'jane.doe');

    expect(find.text('jane.doe'), findsOneWidget);
  });

  testWidgets('shows "Unknown" when there is no username', (tester) async {
    await pumpCard(tester);

    expect(find.text('Unknown'), findsOneWidget);
  });

  testWidgets('shows no image when there is no avatar', (tester) async {
    await pumpCard(tester, userName: 'jane.doe');

    expect(find.byType(Image), findsNothing);
  });
}
