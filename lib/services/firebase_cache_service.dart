import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCacheService {
  static FirebaseCacheService? _instance;
  static FirebaseCacheService get instance => _instance ??= FirebaseCacheService._();
  
  FirebaseCacheService._();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      _isInitialized = true;
    } catch (e) {
      _isInitialized = true;
    }
  }

  Stream<DocumentSnapshot> getDocumentStream(
    String collection,
    String document, {
    bool includeMetadataChanges = true,
  }) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .snapshots(includeMetadataChanges: includeMetadataChanges);
  }

  Stream<QuerySnapshot> getCollectionStream(
    String collection, {
    String? subcollection,
    String? parentDoc,
    int? limit,
    bool includeMetadataChanges = true,
  }) {
    Query query;

    if (subcollection != null && parentDoc != null) {
      query = FirebaseFirestore.instance
          .collection(collection)
          .doc(parentDoc)
          .collection(subcollection);
    } else {
      query = FirebaseFirestore.instance.collection(collection);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots(includeMetadataChanges: includeMetadataChanges);
  }

  Stream<DocumentSnapshot> getUniversityDataStream() {
    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .snapshots(includeMetadataChanges: true)
        .handleError((error) {
          return _getFallbackUniversityStream();
        });
  }

  // Language-specific university data stream
  Stream<DocumentSnapshot> getUniversityDataStreamByLanguage(String languageCode) {
    String docId = getDocumentIdFromLanguage(languageCode);

    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc(docId)
        .snapshots(includeMetadataChanges: true)
        .handleError((error) {
          return _getFallbackUniversityStreamByLanguage(languageCode);
        });
  }

  Stream<DocumentSnapshot> _getFallbackUniversityStreamByLanguage(String languageCode) {
    String docId = getDocumentIdFromLanguage(languageCode);

    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc(docId)
        .collection('administrativeUnits')
        .limit(1)
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final doc = querySnapshot.docs.first;
            return doc;
          } else {
            throw Exception('No documents found in administrativeUnits for language: $languageCode');
          }
        });
  }

  Stream<DocumentSnapshot> _getFallbackUniversityStream() {
    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .collection('administrativeUnits')
        .limit(1)
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final doc = querySnapshot.docs.first;
            return doc;
          } else {
            throw Exception('No documents found in administrativeUnits');
          }
        });
  }

  Stream<QuerySnapshot> getAdministrativeUnitsStream() {
    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .collection('administrativeUnits')
        .snapshots(includeMetadataChanges: true);
  }

  // Language-specific administrative units stream
  Stream<QuerySnapshot> getAdministrativeUnitsStreamByLanguage(String languageCode) {
    String docId = getDocumentIdFromLanguage(languageCode);

    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc(docId)
        .collection('administrativeUnits')
        .snapshots(includeMetadataChanges: true);
  }

  Stream<QuerySnapshot> getFacultiesStream() {
    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .collection('faculties')
        .snapshots(includeMetadataChanges: true);
  }

  // Language-specific faculties stream
  Stream<QuerySnapshot> getFacultiesStreamByLanguage(String languageCode) {
    String docId = getDocumentIdFromLanguage(languageCode);

    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc(docId)
        .collection('faculties')
        .snapshots(includeMetadataChanges: true);
  }

  // Get university information from the new structure
  Stream<QuerySnapshot> getUniversityInfoStreamByLanguage(String languageCode) {
    String docId = getDocumentIdFromLanguage(languageCode);

    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc(docId)
        .collection('university')
        .snapshots(includeMetadataChanges: true);
  }

  // Get university information with fallback
  Future<QuerySnapshot> getUniversityInfoByLanguage(String languageCode) async {
    String docId = getDocumentIdFromLanguage(languageCode);

    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc(docId)
        .collection('university')
        .get(const GetOptions(source: Source.cache))
        .catchError((error) async {
          // If cache fails, try server
          return FirebaseFirestore.instance
              .collection('Kandahar University')
              .doc(docId)
              .collection('university')
              .get(const GetOptions(source: Source.server));
        });
  }

  // Helper method to get document ID from language code
  String getDocumentIdFromLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'fa':
      case 'dari':
        return 'fa';
      case 'en':
      case 'english':
        return 'en';
      case 'ps':
      case 'pashto':
        return 'ps';
      case 'kdru':
        return 'kdru';
      default:
        return 'kdru'; // Default fallback
    }
  }

  // Get teachers from a specific department
  Stream<QuerySnapshot> getTeachersStream(String facultyId, String departmentId) {
    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .collection('faculties')
        .doc(facultyId)
        .collection('departments')
        .doc(departmentId)
        .collection('teachers')
        .snapshots(includeMetadataChanges: true);
  }

  // Get all teachers from all departments in a faculty (for AllFacultyTeachersScreen)
  Stream<QuerySnapshot> getAllFacultyTeachersStream(String facultyId) {
    // This will use collectionGroup to get all teachers from all departments
    return FirebaseFirestore.instance
        .collectionGroup('teachers')
        .where('facultyId', isEqualTo: facultyId)
        .snapshots(includeMetadataChanges: true);
  }

  // Language-specific teachers stream
  Stream<QuerySnapshot> getTeachersStreamByLanguage(String facultyId, String languageCode) {
    String docId = getDocumentIdFromLanguage(languageCode);

    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc(docId)
        .collection('faculties')
        .doc(facultyId)
        .collection('teachers')
        .snapshots(includeMetadataChanges: true);
  }

  Stream<QuerySnapshot> getAllTeachersStream() {
    return FirebaseFirestore.instance
        .collectionGroup('teachers')
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> clearCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      return;
    }
  }

  bool isFromCache(DocumentSnapshot doc) {
    return doc.metadata.isFromCache;
  }

  bool hasPendingWrites(DocumentSnapshot doc) {
    return doc.metadata.hasPendingWrites;
  }

  Map<String, dynamic> getCacheStatus(DocumentSnapshot doc) {
    return {
      'isFromCache': doc.metadata.isFromCache,
      'hasPendingWrites': doc.metadata.hasPendingWrites,
      'source': doc.metadata.isFromCache ? 'Cache' : 'Server',
    };
  }

  Map<String, dynamic> getQueryCacheStatus(QuerySnapshot query) {
    return {
      'isFromCache': query.metadata.isFromCache,
      'hasPendingWrites': query.metadata.hasPendingWrites,
      'source': query.metadata.isFromCache ? 'Cache' : 'Server',
      'docCount': query.docs.length,
    };
  }
}
