import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'localization/app_localizations.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'ps'; // Default language: Pashto
  bool _isLoading = false;
  bool _isInitialized = false;

  // Reference to Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Supported languages
  static const List<String> supportedLanguages = ['ps', 'fa', 'en', 'kdru'];

  String get currentLanguage => _currentLanguage;
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;

  LanguageProvider() {
    _initializeProvider();
  }

  Future<void> _initializeProvider() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('language') ?? 'ps';
      _currentLanguage = savedLanguage;
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing language provider: $e');
      _currentLanguage = 'ps';
      _isInitialized = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    // Validate language code
    if (!supportedLanguages.contains(languageCode)) {
      debugPrint('Unsupported language code: $languageCode');
      return;
    }

    if (_currentLanguage == languageCode) return;

    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', languageCode);
      _currentLanguage = languageCode;

      // Add a small delay to ensure UI updates properly
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      debugPrint('Error changing language: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper method to get language display name
  String getLanguageDisplayName(String languageCode) {
    return getLocalizedString(_getLanguageKey(languageCode));
  }

  String _getLanguageKey(String languageCode) {
    switch (languageCode) {
      case 'ps':
        return 'pashto';
      case 'fa':
        return 'dari';
      case 'en':
        return 'english';
      case 'kdru':
        return 'kdru';
      default:
        return 'pashto';
    }
  }

  // Get the base document reference for the current language
  DocumentReference getBaseDocRef() {
    return _firestore.collection('Kandahar University').doc(_currentLanguage);
  }

  // Get faculties collection reference
  CollectionReference getFacultiesCollectionRef() {
    return getBaseDocRef().collection('faculties');
  }

  // Get departments collection reference for a specific faculty
  CollectionReference getDepartmentsCollectionRef(String facultyId) {
    return getFacultiesCollectionRef().doc(facultyId).collection('departments');
  }

  // Get teachers collection reference for a specific department
  CollectionReference getTeachersCollectionRef(String facultyId, String departmentId) {
    return getDepartmentsCollectionRef(facultyId).doc(departmentId).collection('teachers');
  }

  // Get semesters collection reference for a specific department
  CollectionReference getSemestersCollectionRef(String facultyId, String departmentId) {
    return getDepartmentsCollectionRef(facultyId).doc(departmentId).collection('semesters');
  }

  // Get subjects collection reference for a specific department
  CollectionReference getSubjectsCollectionRef(String facultyId, String departmentId) {
    return getDepartmentsCollectionRef(facultyId).doc(departmentId).collection('subjects');
  }

  // Get staff collection reference for a specific faculty
  CollectionReference getStaffCollectionRef(String facultyId) {
    return getFacultiesCollectionRef().doc(facultyId).collection('staff');
  }

  // Get administrative units collection reference
  CollectionReference getAdministrativeUnitsCollectionRef() {
    return getBaseDocRef().collection('administrativeUnits');
  }

  // Get university collection reference
  CollectionReference getUniversityCollectionRef() {
    return getBaseDocRef().collection('university');
  }

  // Get university document reference by ID
  DocumentReference getUniversityDocRef(String universityId) {
    return getUniversityCollectionRef().doc(universityId);
  }

  // Get localized string
  String getLocalizedString(String key) {
    return AppLocalizations.getString(key, _currentLanguage);
  }

  // Get text direction based on current language
  TextDirection getTextDirection() {
    switch (_currentLanguage) {
      case 'en':
        return TextDirection.ltr;
      case 'ps':
      case 'fa':
      case 'kdru':
      default:
        return TextDirection.rtl;
    }
  }

  // Get font family based on current language
  String getFontFamily() {
    switch (_currentLanguage) {
      case 'en':
        return 'Roboto';
      case 'ps':
      case 'fa':
      case 'kdru':
      default:
        return 'pashto';
    }
  }
}
