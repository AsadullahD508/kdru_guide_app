import 'package:flutter/foundation.dart';

class PerformanceConfig {
  static const int maxImageCacheSize = 100;
  static const int maxImageCacheObjects = 1000;
  static const Duration imageCacheDuration = Duration(days: 1000);

  static const int defaultMemCacheWidth = 200;
  static const int defaultMemCacheHeight = 200;
  static const int thumbnailMemCacheWidth = 100;
  static const int thumbnailMemCacheHeight = 100;
  static const int headerMemCacheWidth = 400;
  static const int headerMemCacheHeight = 300;

  static const Duration firebaseCacheTimeout = Duration(minutes: 5);
  static const int maxFirebaseRetries = 3;
  static const Duration firebaseRetryDelay = Duration(seconds: 2);

  static const double listCacheExtent = 500.0;
  static const bool keepAlivesEnabled = false;
  static const bool repaintBoundariesEnabled = false;

  static const Duration fastAnimationDuration = Duration(milliseconds: 200);
  static const Duration normalAnimationDuration = Duration(milliseconds: 300);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  static const Duration defaultDebounceTime = Duration(milliseconds: 100);
  static const Duration searchDebounceTime = Duration(milliseconds: 300);
  static const Duration scrollDebounceTime = Duration(milliseconds: 50);

  static const bool enablePerformanceMonitoring = kDebugMode;
  static const bool enableBuildTimeLogging = kDebugMode;
  static const bool enableMemoryLogging = kDebugMode;
  static const int slowBuildThresholdMs = 16;

  static const Duration networkTimeout = Duration(seconds: 10);
  static const int maxConcurrentNetworkRequests = 6;

  static const Duration lazyLoadDelay = Duration(milliseconds: 100);
  static const int lazyLoadBatchSize = 10;

  static const Duration widgetCacheDuration = Duration(minutes: 5);
  static const int maxCachedWidgets = 50;

  static const int firebaseBatchSize = 10;
  static const Duration batchDelay = Duration(milliseconds: 50);

  static const double imageQuality = 0.8;
  static const bool enableImageCompression = true;
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1080;

  static const Duration memoryCleanupInterval = Duration(minutes: 5);
  static const double memoryWarningThreshold = 0.8;

  static const Duration uiUpdateThrottle = Duration(milliseconds: 16);
  static const int maxUIUpdatesPerSecond = 60;

  static const int maxErrorRetries = 3;
  static const Duration errorRetryDelay = Duration(seconds: 1);
  static const bool enableErrorLogging = true;

  static const bool enableDebugPrints = kDebugMode;
  static const bool enablePerformanceOverlay = false;
  static const bool enableWidgetInspector = kDebugMode;

  // Platform-specific optimizations
  static bool get isHighPerformanceDevice {
    // This would typically check device specs
    // For now, assume all devices are capable
    return true;
  }

  static bool get enableAdvancedOptimizations {
    return isHighPerformanceDevice && !kDebugMode;
  }

  // Dynamic configuration based on device performance
  static int getOptimalImageCacheSize() {
    if (isHighPerformanceDevice) {
      return maxImageCacheSize;
    } else {
      return maxImageCacheSize ~/ 2; // Half for lower-end devices
    }
  }

  static double getOptimalCacheExtent() {
    if (isHighPerformanceDevice) {
      return listCacheExtent;
    } else {
      return listCacheExtent / 2; // Smaller cache for lower-end devices
    }
  }

  static Duration getOptimalAnimationDuration() {
    if (isHighPerformanceDevice) {
      return fastAnimationDuration;
    } else {
      return normalAnimationDuration;
    }
  }

  // Memory optimization settings
  static const bool enableMemoryOptimizations = true;
  static const bool enableImageMemoryOptimizations = true;
  static const bool enableWidgetMemoryOptimizations = true;

  // Network optimization settings
  static const bool enableNetworkOptimizations = true;
  static const bool enableImagePreloading = false; // Disabled to save bandwidth
  static const bool enablePrefetching = false; // Disabled to save memory

  // Firebase optimization settings
  static const bool enableFirebaseOptimizations = true;
  static const bool enableFirebaseCaching = true;
  static const bool enableFirebaseBatching = true;

  // UI optimization settings
  static const bool enableUIOptimizations = true;
  static const bool enableLazyLoading = true;
  static const bool enableWidgetCaching = true;
  static const bool enableDebouncedUpdates = true;

  // Logging configuration
  static void logPerformance(String message) {
    if (enableDebugPrints) {
      debugPrint('🚀 Performance: $message');
    }
  }

  static void logError(String message, [Object? error]) {
    if (enableErrorLogging) {
      debugPrint('❌ Error: $message${error != null ? ' - $error' : ''}');
    }
  }

  static void logMemory(String message) {
    if (enableMemoryLogging) {
      debugPrint('💾 Memory: $message');
    }
  }

  static void logBuildTime(String widget, int milliseconds) {
    if (enableBuildTimeLogging && milliseconds > slowBuildThresholdMs) {
      debugPrint('⏱️ Slow build: $widget took ${milliseconds}ms');
    }
  }
}
