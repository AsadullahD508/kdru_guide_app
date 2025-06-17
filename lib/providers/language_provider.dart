import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'ps'; // Default language
  bool _isLoading = false;
  
  // Reference to Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get currentLanguage => _currentLanguage;
  bool get isLoading => _isLoading;

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('language') ?? 'ps';
      await changeLanguage(savedLanguage);
    } catch (e) {
      debugPrint('Error loading saved language: $e');
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage == languageCode) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', languageCode);
      _currentLanguage = languageCode;
      
      // Add a small delay to ensure UI updates properly
      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      debugPrint('Error changing language: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
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
}
