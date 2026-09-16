import 'package:flutter_test/flutter_test.dart';
import 'package:untitled4/main.dart';

void main() {
  testWidgets('Portfolio loads core content', (WidgetTester tester) async {
    await tester.pumpWidget(const FayPortfolio());
    await tester.pumpAndSettle();

    expect(find.text('FAY AL-MUTAIRI'), findsOneWidget);
    expect(find.text('Fay Al-Mutairi'), findsWidgets);
    expect(find.textContaining('Information Technology'), findsWidgets);
  });
}
