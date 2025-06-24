import 'package:flutter_test/flutter_test.dart';
import 'package:kdru_guide_app/localization/app_localizations.dart';

void main() {
  group('AppLocalizations Tests', () {
    group('Localization Keys Validation', () {
      test('should have all required keys in all languages', () {
        final requiredKeys = [
          'app_title',
          'welcome_message',
          'faculties',
          'departments',
          'teachers',
          'loading',
          'cancel',
          'ok',
          'exit_app',
          'exit_app_confirmation',
          'search_teachers',
          'search_teacher_hint',
          'searching',
          'no_teachers_found',
          'guest_user',
          'home',
          'about',
          'contact_us',
          'our_services',
        ];

        // Test Pashto (ps)
        for (String key in requiredKeys) {
          final value = AppLocalizations.getString(key, 'ps');
          expect(value, isNotNull, reason: 'Pashto missing key: $key');
          expect(value, isNotEmpty, reason: 'Pashto empty value for key: $key');
        }

        // Test Dari (fa)
        for (String key in requiredKeys) {
          final value = AppLocalizations.getString(key, 'fa');
          expect(value, isNotNull, reason: 'Dari missing key: $key');
          expect(value, isNotEmpty, reason: 'Dari empty value for key: $key');
        }

        // Test English (en)
        for (String key in requiredKeys) {
          final value = AppLocalizations.getString(key, 'en');
          expect(value, isNotNull, reason: 'English missing key: $key');
          expect(value, isNotEmpty, reason: 'English empty value for key: $key');
        }
      });

      test('should return consistent values for same keys', () {
        const testKey = 'app_title';
        
        final pashtoValue = AppLocalizations.getString(testKey, 'ps');
        final dariValue = AppLocalizations.getString(testKey, 'fa');
        final englishValue = AppLocalizations.getString(testKey, 'en');

        // All should be non-null and non-empty
        expect(pashtoValue, isNotNull);
        expect(dariValue, isNotNull);
        expect(englishValue, isNotNull);
        expect(pashtoValue, isNotEmpty);
        expect(dariValue, isNotEmpty);
        expect(englishValue, isNotEmpty);

        // Values should be different (different languages)
        expect(pashtoValue, isNot(equals(englishValue)));
        expect(dariValue, isNot(equals(englishValue)));
      });

      test('should handle invalid language codes gracefully', () {
        const testKey = 'app_title';
        
        final result = AppLocalizations.getString(testKey, 'invalid');
        expect(result, isNotNull);
        expect(result, isNotEmpty);
      });

      test('should handle invalid keys gracefully', () {
        const invalidKey = 'non_existent_key_12345';
        
        final pashtoResult = AppLocalizations.getString(invalidKey, 'ps');
        final dariResult = AppLocalizations.getString(invalidKey, 'fa');
        final englishResult = AppLocalizations.getString(invalidKey, 'en');

        expect(pashtoResult, isNotNull);
        expect(dariResult, isNotNull);
        expect(englishResult, isNotNull);
      });
    });

    group('Exit Confirmation Localization', () {
      test('should have proper exit confirmation messages', () {
        // Test that exit confirmation messages are meaningful
        final languages = ['ps', 'fa', 'en'];
        
        for (String lang in languages) {
          final exitApp = AppLocalizations.getString('exit_app', lang);
          final exitConfirmation = AppLocalizations.getString('exit_app_confirmation', lang);
          final cancel = AppLocalizations.getString('cancel', lang);
          final ok = AppLocalizations.getString('ok', lang);

          expect(exitApp, isNotEmpty, reason: '$lang exit_app is empty');
          expect(exitConfirmation, isNotEmpty, reason: '$lang exit_app_confirmation is empty');
          expect(cancel, isNotEmpty, reason: '$lang cancel is empty');
          expect(ok, isNotEmpty, reason: '$lang ok is empty');

          // Exit confirmation should be longer (it's a question)
          expect(exitConfirmation.length, greaterThan(exitApp.length));
        }
      });
    });

    group('Search Functionality Localization', () {
      test('should have proper search-related messages', () {
        final languages = ['ps', 'fa', 'en'];
        
        for (String lang in languages) {
          final searchTeachers = AppLocalizations.getString('search_teachers', lang);
          final searchHint = AppLocalizations.getString('search_teacher_hint', lang);
          final searching = AppLocalizations.getString('searching', lang);
          final noTeachersFound = AppLocalizations.getString('no_teachers_found', lang);

          expect(searchTeachers, isNotEmpty, reason: '$lang search_teachers is empty');
          expect(searchHint, isNotEmpty, reason: '$lang search_teacher_hint is empty');
          expect(searching, isNotEmpty, reason: '$lang searching is empty');
          expect(noTeachersFound, isNotEmpty, reason: '$lang no_teachers_found is empty');
        }
      });
    });

    group('Navigation and UI Localization', () {
      test('should have proper navigation and UI messages', () {
        final languages = ['ps', 'fa', 'en'];
        final uiKeys = [
          'home',
          'faculties',
          'departments',
          'teachers',
          'loading',
          'guest_user',
          'welcome_message',
          'our_services',
          'contact_us',
        ];
        
        for (String lang in languages) {
          for (String key in uiKeys) {
            final value = AppLocalizations.getString(key, lang);
            expect(value, isNotEmpty, reason: '$lang $key is empty');
          }
        }
      });
    });

    group('Language-Specific Character Validation', () {
      test('should contain appropriate characters for each language', () {
        // Test Pashto - should contain Pashto/Arabic script
        final pashtoText = AppLocalizations.getString('welcome_message', 'ps');
        expect(pashtoText, matches(RegExp(r'[\u0600-\u06FF\u0750-\u077F]')),
               reason: 'Pashto text should contain Arabic/Pashto script characters');

        // Test Dari - should contain Persian/Arabic script
        final dariText = AppLocalizations.getString('welcome_message', 'fa');
        expect(dariText, matches(RegExp(r'[\u0600-\u06FF\u0750-\u077F]')),
               reason: 'Dari text should contain Arabic/Persian script characters');

        // Test English - should contain Latin script
        final englishText = AppLocalizations.getString('welcome_message', 'en');
        expect(englishText, matches(RegExp(r'[a-zA-Z]')), 
               reason: 'English text should contain Latin script characters');
      });
    });

    group('Consistency Tests', () {
      test('should have consistent key availability across languages', () {
        final languages = ['ps', 'fa', 'en'];
        final testKeys = [
          'app_title',
          'faculties',
          'departments',
          'teachers',
          'search_teachers',
          'exit_app',
          'cancel',
          'ok',
        ];

        for (String key in testKeys) {
          final values = languages.map((lang) =>
            AppLocalizations.getString(key, lang)).toList();
          
          // All languages should have non-empty values for the same key
          for (int i = 0; i < values.length; i++) {
            expect(values[i], isNotEmpty, 
                   reason: 'Language ${languages[i]} missing value for key: $key');
          }
        }
      });
    });
  });
}
