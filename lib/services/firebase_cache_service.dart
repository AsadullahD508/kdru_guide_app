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

  Stream<QuerySnapshot> getFacultiesStream() {
    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .collection('faculties')
        .snapshots(includeMetadataChanges: true);
  }

  Stream<QuerySnapshot> getTeachersStream(String facultyId) {
    return FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
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
