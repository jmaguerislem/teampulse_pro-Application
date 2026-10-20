import 'package:flutter_test/flutter_test.dart';
import 'package:teampulse_pro/main.dart';
import 'package:teampulse_pro/screens/welcome_screen.dart';

void main() {
  testWidgets('Affiche l\'écran d\'accueil', (WidgetTester tester) async {
    await tester.pumpWidget(const TeamPulseApp());
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });
}
