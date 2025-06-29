import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../services/firebase_cache_service.dart';
import '../models/administrative_unit_model.dart';

class DatabaseTestWidget extends StatefulWidget {
  const DatabaseTestWidget({super.key});

  @override
  State<DatabaseTestWidget> createState() => _DatabaseTestWidgetState();
}

class _DatabaseTestWidgetState extends State<DatabaseTestWidget> {
  String _testResults = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database & Localization Test'),
        backgroundColor: const Color(0xFF20C0C7),
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Language Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Language: ${languageProvider.currentLanguage}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Text Direction: ${languageProvider.getTextDirection()}'),
                        Text('Font Family: ${languageProvider.getFontFamily()}'),
                        const SizedBox(height: 8),
                        Text(
                          'Localized Test: ${languageProvider.getLocalizedString('teachers')}',
                          style: TextStyle(
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          textDirection: languageProvider.getTextDirection(),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Test Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _testDatabaseConnection(languageProvider),
                        child: const Text('Test Database'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _testAdminUnits(languageProvider),
                        child: const Text('Test Admin Units'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Language Switcher
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => languageProvider.changeLanguage('ps'),
                      child: const Text('Pashto'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => languageProvider.changeLanguage('fa'),
                      child: const Text('Dari'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => languageProvider.changeLanguage('en'),
                      child: const Text('English'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => languageProvider.changeLanguage('kdru'),
                      child: const Text('KDRU'),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Results
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Test Results:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          if (_isLoading)
                            const Center(child: CircularProgressIndicator())
                          else
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  _testResults.isEmpty ? 'No tests run yet' : _testResults,
                                  style: const TextStyle(fontFamily: 'monospace'),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _testDatabaseConnection(LanguageProvider languageProvider) async {
    setState(() {
      _isLoading = true;
      _testResults = 'Testing database connection...\n';
    });

    try {
      // Test basic Firestore connection
      final testDoc = await FirebaseFirestore.instance
          .collection('test')
          .doc('connection')
          .get();

      setState(() {
        _testResults += '✓ Firestore connection: OK\n';
      });

      // Test language-specific path
      final docId = FirebaseCacheService.instance.getDocumentIdFromLanguage(languageProvider.currentLanguage);
      setState(() {
        _testResults += 'Language: ${languageProvider.currentLanguage} -> Document ID: $docId\n';
      });

      // Test university collection access
      final universityRef = FirebaseFirestore.instance
          .collection('Kandahar University')
          .doc(docId);

      final universityDoc = await universityRef.get();
      setState(() {
        _testResults += 'University document exists: ${universityDoc.exists}\n';
      });

      if (universityDoc.exists) {
        final data = universityDoc.data() as Map<String, dynamic>?;
        setState(() {
          _testResults += 'University data keys: ${data?.keys.toList()}\n';
        });
      }

    } catch (e) {
      setState(() {
        _testResults += '✗ Database error: $e\n';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _testAdminUnits(LanguageProvider languageProvider) async {
    setState(() {
      _isLoading = true;
      _testResults = 'Testing administrative units...\n';
    });

    try {
      // Test administrative units collection
      final docId = FirebaseCacheService.instance.getDocumentIdFromLanguage(languageProvider.currentLanguage);
      
      setState(() {
        _testResults += 'Testing path: Kandahar University/$docId/administrativeUnits\n';
      });

      final adminUnitsSnapshot = await FirebaseFirestore.instance
          .collection('Kandahar University')
          .doc(docId)
          .collection('administrativeUnits')
          .get();

      setState(() {
        _testResults += 'Administrative units found: ${adminUnitsSnapshot.docs.length}\n';
      });

      if (adminUnitsSnapshot.docs.isNotEmpty) {
        for (int i = 0; i < adminUnitsSnapshot.docs.length && i < 3; i++) {
          final doc = adminUnitsSnapshot.docs[i];
          final adminUnit = AdministrativeUnitModel.fromFirestore(doc);
          
          setState(() {
            _testResults += '\nUnit ${i + 1}:\n';
            _testResults += '  ID: ${adminUnit.id}\n';
            _testResults += '  Name: ${adminUnit.name}\n';
            _testResults += '  Director: ${adminUnit.director}\n';
            _testResults += '  Has Info: ${adminUnit.information.isNotEmpty}\n';
            _testResults += '  Localized Name: ${adminUnit.getLocalizedName(languageProvider)}\n';
          });
        }
      } else {
        setState(() {
          _testResults += 'No administrative units found in this language collection.\n';
        });
        
        // Try fallback to kdru collection
        final fallbackSnapshot = await FirebaseFirestore.instance
            .collection('Kandahar University')
            .doc('kdru')
            .collection('administrativeUnits')
            .get();
            
        setState(() {
          _testResults += 'Fallback (kdru) units found: ${fallbackSnapshot.docs.length}\n';
        });
      }

    } catch (e) {
      setState(() {
        _testResults += '✗ Admin units error: $e\n';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }
}
