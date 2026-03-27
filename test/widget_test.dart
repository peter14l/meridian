import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meridian/main.dart';

void main() {
  testWidgets('Meridian app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MeridianApp()));

    // Verify that our app starts.
    expect(find.text('Meridian Tasks'), findsOneWidget);
  });
}
