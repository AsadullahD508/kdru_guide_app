import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'unit/language_provider_test.dart' as language_provider_tests;
import 'unit/app_localizations_test.dart' as localization_tests;
import 'unit/responsive_utils_test.dart' as responsive_tests;
import 'widget/home_screen_test.dart' as home_screen_tests;
import 'widget/teacher_search_test.dart' as search_tests;

void main() {
  group('Kdru Guide App Tests', () {
    group('Unit Tests', () {
      group('Language Provider Tests', () {
        language_provider_tests.main();
      });

      group('Localization Tests', () {
        localization_tests.main();
      });

      group('Responsive Utils Tests', () {
        responsive_tests.main();
      });
    });

    group('Widget Tests', () {
      group('Home Screen Tests', () {
        home_screen_tests.main();
      });

      group('Teacher Search Tests', () {
        search_tests.main();
      });
    });
  });
}
