import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kdru_guide_app/services/firebase_cache_service.dart';
import 'package:kdru_guide_app/models/administrative_unit_model.dart';
import 'package:kdru_guide_app/localization/app_localizations.dart';

void main() {
  group('Database Connection Tests', () {
    late FirebaseCacheService cacheService;

    setUp(() {
      // Initialize services that don't require Firebase
      cacheService = FirebaseCacheService.instance;
    });

    group('Firebase Cache Service Tests', () {
      test('should return correct document ID for language codes', () {
        expect(cacheService.getDocumentIdFromLanguage('ps'), equals('ps'));
        expect(cacheService.getDocumentIdFromLanguage('pashto'), equals('ps'));
        expect(cacheService.getDocumentIdFromLanguage('fa'), equals('fa'));
        expect(cacheService.getDocumentIdFromLanguage('dari'), equals('fa'));
        expect(cacheService.getDocumentIdFromLanguage('en'), equals('en'));
        expect(cacheService.getDocumentIdFromLanguage('english'), equals('en'));
        expect(cacheService.getDocumentIdFromLanguage('kdru'), equals('kdru'));
        expect(cacheService.getDocumentIdFromLanguage('invalid'), equals('kdru'));
      });

      test('should handle case insensitive language codes', () {
        expect(cacheService.getDocumentIdFromLanguage('PS'), equals('ps'));
        expect(cacheService.getDocumentIdFromLanguage('EN'), equals('en'));
        expect(cacheService.getDocumentIdFromLanguage('FA'), equals('fa'));
      });
    });

    group('Localization Tests', () {
      test('should return localized strings for different languages', () {
        expect(AppLocalizations.getString('teachers', 'ps'), isNotEmpty);
        expect(AppLocalizations.getString('teachers', 'fa'), isNotEmpty);
        expect(AppLocalizations.getString('teachers', 'en'), isNotEmpty);
        expect(AppLocalizations.getString('teachers', 'kdru'), isNotEmpty);
      });

      test('should return fallback for invalid keys', () {
        expect(AppLocalizations.getString('invalid_key', 'ps'), equals('invalid_key'));
        expect(AppLocalizations.getString('invalid_key', 'en'), equals('invalid_key'));
      });

      test('should handle different language codes', () {
        expect(AppLocalizations.getString('home', 'ps'), isNotEmpty);
        expect(AppLocalizations.getString('home', 'fa'), isNotEmpty);
        expect(AppLocalizations.getString('home', 'en'), equals('Home'));
        expect(AppLocalizations.getString('home', 'kdru'), isNotEmpty);
      });
    });

    group('Administrative Unit Model Tests', () {
      test('should create model with complete data', () {
        // Test model creation with complete data
        final model = AdministrativeUnitModel(
          id: 'test-id',
          name: 'Test Administration',
          director: 'Test Director',
          information: 'Test Information',
          vision: 'Test Vision',
          mission: 'Test Mission',
          goals: 'Test Goals',
          year: '2020',
          logo: 'test_logo.png',
          organ: 'test_organ.png',
          innovativeProjects: 'Test Projects',
          internationalRelations: 'Test Relations',
          qualityEnhancement: 'Test Quality',
          description: 'Test Description',
          contactInfo: {
            'email': 'test@example.com',
            'phone': '+93123456789'
          },
        );

        expect(model.name, equals('Test Administration'));
        expect(model.director, equals('Test Director'));
        expect(model.information, equals('Test Information'));
        expect(model.vision, equals('Test Vision'));
        expect(model.mission, equals('Test Mission'));
        expect(model.contactInfo, isNotNull);
        expect(model.contactInfo!['email'], equals('test@example.com'));
      });

      test('should handle missing fields gracefully', () {
        final model = AdministrativeUnitModel(
          id: 'test-id',
          name: '',
          director: '',
          information: '',
          vision: '',
          mission: '',
          goals: '',
          year: '',
          logo: '',
          organ: '',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        expect(model.name, equals(''));
        expect(model.director, equals(''));
        expect(model.information, equals(''));
        expect(model.contactInfo, isNull);
      });

      test('should provide basic string access', () {
        final model = AdministrativeUnitModel(
          id: 'test-id',
          name: 'Test Name',
          director: 'Test Director',
          information: 'Test Info',
          vision: 'Test Vision',
          mission: 'Test Mission',
          goals: 'Test Goals',
          year: '2020',
          logo: '',
          organ: '',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        expect(model.name, equals('Test Name'));
        expect(model.director, equals('Test Director'));
        expect(model.information, equals('Test Info'));
        expect(model.vision, equals('Test Vision'));
        expect(model.mission, equals('Test Mission'));
      });

      test('should check if unit has complete information', () {
        final completeModel = AdministrativeUnitModel(
          id: 'complete-id',
          name: 'Test Name',
          director: 'Test Director',
          information: 'Test Info',
          vision: '',
          mission: '',
          goals: '',
          year: '',
          logo: '',
          organ: '',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        final incompleteModel = AdministrativeUnitModel(
          id: 'incomplete-id',
          name: 'Test Name',
          director: '',
          information: '',
          vision: '',
          mission: '',
          goals: '',
          year: '',
          logo: '',
          organ: '',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        expect(completeModel.hasCompleteInfo, isTrue);
        expect(incompleteModel.hasCompleteInfo, isFalse);
      });

      test('should return correct image URL priority', () {
        final logoModel = AdministrativeUnitModel(
          id: 'logo-id',
          name: 'Test',
          director: '',
          information: '',
          vision: '',
          mission: '',
          goals: '',
          year: '',
          logo: 'logo.png',
          organ: 'organ.png',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        final organModel = AdministrativeUnitModel(
          id: 'organ-id',
          name: 'Test',
          director: '',
          information: '',
          vision: '',
          mission: '',
          goals: '',
          year: '',
          logo: '',
          organ: 'organ.png',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        final noImageModel = AdministrativeUnitModel(
          id: 'noimage-id',
          name: 'Test',
          director: '',
          information: '',
          vision: '',
          mission: '',
          goals: '',
          year: '',
          logo: '',
          organ: '',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        expect(logoModel.imageUrl, equals('logo.png'));
        expect(organModel.imageUrl, equals('organ.png'));
        expect(noImageModel.imageUrl, equals(''));
      });
    });

    group('Database Path Construction Tests', () {
      test('should construct correct Firestore paths for different languages', () {
        final testCases = [
          {'language': 'ps', 'expected': 'Kandahar University/ps'},
          {'language': 'fa', 'expected': 'Kandahar University/fa'},
          {'language': 'en', 'expected': 'Kandahar University/en'},
          {'language': 'kdru', 'expected': 'Kandahar University/kdru'},
        ];

        for (final testCase in testCases) {
          final language = testCase['language'] as String;
          final expected = testCase['expected'] as String;
          final docId = cacheService.getDocumentIdFromLanguage(language);
          final path = 'Kandahar University/$docId';
          
          expect(path, equals(expected));
        }
      });

      test('should construct administrative units collection path', () {
        final languages = ['ps', 'fa', 'en', 'kdru'];
        
        for (final language in languages) {
          final docId = cacheService.getDocumentIdFromLanguage(language);
          final path = 'Kandahar University/$docId/administrativeUnits';
          
          expect(path, contains('Kandahar University'));
          expect(path, contains(docId));
          expect(path, endsWith('administrativeUnits'));
        }
      });
    });

    group('Error Handling Tests', () {
      test('should handle empty model creation', () {
        expect(() {
          AdministrativeUnitModel(
            id: 'empty-id',
            name: '',
            director: '',
            information: '',
            vision: '',
            mission: '',
            goals: '',
            year: '',
            logo: '',
            organ: '',
            innovativeProjects: '',
            internationalRelations: '',
            qualityEnhancement: '',
            description: '',
            contactInfo: null,
          );
        }, returnsNormally);
      });

      test('should handle null contact info', () {
        final model = AdministrativeUnitModel(
          id: 'test-id',
          name: 'Test',
          director: '',
          information: '',
          vision: '',
          mission: '',
          goals: '',
          year: '',
          logo: '',
          organ: '',
          innovativeProjects: '',
          internationalRelations: '',
          qualityEnhancement: '',
          description: '',
          contactInfo: null,
        );

        expect(model.contactInfo, isNull);
      });
    });
  });
}
