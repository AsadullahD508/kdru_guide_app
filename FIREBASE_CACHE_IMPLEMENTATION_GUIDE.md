# Firebase Cache Implementation Guide

## Overview
This guide shows how to implement Firebase offline persistence with proper cache management across your entire Flutter project. The implementation ensures:

- **Data remains cached** until app uninstall or database deletion
- **Automatic sync** when database changes
- **Cache removal** when data is deleted from database
- **Offline functionality** with cached data
- **Real-time updates** when online

## 🚀 Implementation Steps

### 1. Initialize Firebase Caching in main.dart

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'services/firebase_cache_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Firebase offline persistence and caching
  await FirebaseCacheService.instance.initialize();
  
  runApp(const MyApp());
}
```

### 2. Core Cache Service (lib/services/firebase_cache_service.dart)

The `FirebaseCacheService` provides:
- ✅ **Unlimited cache size**
- ✅ **Automatic persistence**
- ✅ **Real-time sync**
- ✅ **Multiple data streams**
- ✅ **Cache management**

Key methods:
- `getUniversityDataStream()` - University data with fallback
- `getFacultiesStream()` - All faculties
- `getTeachersStream(facultyId)` - Teachers for specific faculty
- `getAllTeachersStream()` - All teachers across faculties
- `getAdministrativeUnitsStream()` - Administrative units
- `clearCache()` - Clear all cached data

### 3. Cache Status Widgets (lib/widgets/cache_status_widget.dart)

Three widgets for different use cases:

#### CacheStatusWidget
Shows detailed cache status with document/query count:
```dart
CacheStatusWidget(document: snapshot.data)
CacheStatusWidget(query: snapshot.data)
```

#### SimpleCacheStatusWidget
Compact cache indicator:
```dart
SimpleCacheStatusWidget(
  isFromCache: snapshot.data!.metadata.isFromCache,
  hasPendingWrites: snapshot.data!.metadata.hasPendingWrites,
)
```

#### LoadingWithCacheWidget & ErrorWithRetryWidget
Enhanced loading and error states with cache information.

### 4. Localization Strings Added

Cache-related strings in all languages (Pashto, Dari, English, KDRU):
- `loaded_from_cache` - "د کیش څخه لوډ شوي (آفلاین)"
- `loaded_from_server` - "د سرور څخه لوډ شوي (آنلاین)"
- `offline` - "آفلاین"
- `online` - "آنلاین"
- `syncing` - "د سینک کولو په انتظار کې"
- `clear_cache` - "کیش پاک کړه"
- And more...

## 📱 Screen Implementation Examples

### Example 1: DirectorateScreen (Document-based)

```dart
StreamBuilder<DocumentSnapshot>(
  stream: FirebaseCacheService.instance.getUniversityDataStream(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingWithCacheWidget();
    }

    if (snapshot.hasError) {
      return ErrorWithRetryWidget(
        error: snapshot.error.toString(),
        onRetry: () => (context as Element).markNeedsBuild(),
        onClearCache: () async {
          await FirebaseCacheService.instance.clearCache();
          if (context.mounted) (context as Element).markNeedsBuild();
        },
      );
    }

    if (!snapshot.hasData || !snapshot.data!.exists) {
      return const Center(child: Text('No data available'));
    }

    final data = snapshot.data!.data() as Map<String, dynamic>;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Cache Status Indicator
          CacheStatusWidget(document: snapshot.data),
          
          // Your content here
          _buildContent(data),
        ],
      ),
    );
  },
)
```

### Example 2: AllFacultyTeachersScreen (Collection-based)

```dart
StreamBuilder<QuerySnapshot>(
  stream: FirebaseCacheService.instance.getTeachersStream(facultyId),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingWithCacheWidget();
    }

    if (snapshot.hasError) {
      return ErrorWithRetryWidget(
        error: snapshot.error.toString(),
        onRetry: () => (context as Element).markNeedsBuild(),
        onClearCache: () async {
          await FirebaseCacheService.instance.clearCache();
          if (context.mounted) (context as Element).markNeedsBuild();
        },
      );
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('No teachers found'));
    }

    final teachers = snapshot.data!.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {...data, 'id': doc.id};
    }).toList();

    return Column(
      children: [
        // Cache Status Indicator
        CacheStatusWidget(query: snapshot.data),
        
        // Teachers List
        Expanded(
          child: ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (context, index) => _buildTeacherCard(teachers[index]),
          ),
        ),
      ],
    );
  },
)
```

## 🔄 How Caching Works

### Data Flow:
1. **First Load**: Data fetched from server → Cached locally
2. **Subsequent Loads**: Data loaded from cache instantly
3. **Online Updates**: Server changes sync automatically
4. **Offline Mode**: App works with cached data
5. **Data Deletion**: Cache cleared when server data deleted

### Cache Behavior:
- **Persistent**: Survives app restarts
- **Unlimited Size**: No storage limits
- **Real-time**: Syncs when online
- **Automatic**: No manual intervention needed

## 🛠️ Migration Guide for Existing Screens

### Step 1: Update Imports
```dart
import '../../services/firebase_cache_service.dart';
import '../../widgets/cache_status_widget.dart';
```

### Step 2: Replace Direct Firebase Calls
**Before:**
```dart
FirebaseFirestore.instance.collection('path').snapshots()
```

**After:**
```dart
FirebaseCacheService.instance.getCollectionStream('path')
```

### Step 3: Add Cache Status Indicators
```dart
// Add after StreamBuilder data check
CacheStatusWidget(document: snapshot.data), // For documents
CacheStatusWidget(query: snapshot.data),    // For collections
```

### Step 4: Update Error Handling
```dart
if (snapshot.hasError) {
  return ErrorWithRetryWidget(
    error: snapshot.error.toString(),
    onRetry: () => (context as Element).markNeedsBuild(),
    onClearCache: () async {
      await FirebaseCacheService.instance.clearCache();
      if (context.mounted) (context as Element).markNeedsBuild();
    },
  );
}
```

### Step 5: Update Loading States
```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return const LoadingWithCacheWidget();
}
```

## 📊 Cache Status Indicators

Users will see:
- 🟢 **Green**: "د سرور څخه لوډ شوي (آنلاین)" - Data from server
- 🟠 **Orange**: "د کیش څخه لوډ شوي (آفلاین)" - Data from cache
- 🔄 **Blue**: "د سینک کولو په انتظار کې" - Syncing pending

## 🎯 Benefits

### For Users:
- ✅ **Instant loading** from cache
- ✅ **Offline functionality**
- ✅ **Reduced data usage**
- ✅ **Better performance**

### For Developers:
- ✅ **Simplified code**
- ✅ **Automatic sync**
- ✅ **Error handling**
- ✅ **Debug information**

## 🔧 Troubleshooting

### Clear Cache for Testing:
```dart
await FirebaseCacheService.instance.clearCache();
```

### Debug Cache Status:
```dart
debugPrint('Data source: ${snapshot.data!.metadata.isFromCache ? "Cache" : "Server"}');
```

### Check Cache Size:
Firebase automatically manages cache size with unlimited storage.

## 📝 Next Steps

1. **Update all screens** using the migration guide
2. **Test offline functionality** by disabling internet
3. **Verify cache persistence** by restarting the app
4. **Monitor performance** improvements

This implementation ensures your app works seamlessly online and offline while providing users with clear feedback about data sources and sync status.
