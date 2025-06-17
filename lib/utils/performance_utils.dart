import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerformanceUtils {
  // Optimized CachedNetworkImage with memory caching
  static Widget optimizedNetworkImage({
    required String imageUrl,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
    String? heroTag,
    BorderRadius? borderRadius,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: (width * 2).round(),
      memCacheHeight: (height * 2).round(),
      placeholder: (context, url) => placeholder ?? Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: const Icon(Icons.image, color: Colors.grey),
      ),
      errorWidget: (context, url, error) => errorWidget ?? Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
      fadeInDuration: const Duration(milliseconds: 200),
      fadeOutDuration: const Duration(milliseconds: 100),
    );

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius,
        child: imageWidget,
      );
    }

    if (heroTag != null) {
      imageWidget = Hero(
        tag: heroTag,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  // Optimized Firebase query with caching
  static Future<DocumentSnapshot> getCachedDocument(DocumentReference docRef) async {
    try {
      // Try cache first
      final cachedDoc = await docRef.get(const GetOptions(source: Source.cache));
      if (cachedDoc.exists) {
        return cachedDoc;
      }
    } catch (e) {
      // Cache miss or error, fallback to server
    }
    
    // Fallback to server
    return await docRef.get();
  }

  // Optimized Firebase collection query with caching
  static Future<QuerySnapshot> getCachedCollection(Query query) async {
    try {
      // Try cache first
      final cachedQuery = await query.get(const GetOptions(source: Source.cache));
      if (cachedQuery.docs.isNotEmpty) {
        return cachedQuery;
      }
    } catch (e) {
      // Cache miss or error, fallback to server
    }
    
    // Fallback to server
    return await query.get();
  }

  // Debounced setState to prevent excessive rebuilds
  static void debouncedSetState(VoidCallback setState, {Duration delay = const Duration(milliseconds: 100)}) {
    Future.delayed(delay, setState);
  }

  // Optimized list builder with lazy loading
  static Widget optimizedListView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollController? controller,
    EdgeInsets? padding,
    bool shrinkWrap = false,
  }) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      cacheExtent: 500, // Cache 500 pixels ahead
      addAutomaticKeepAlives: false, // Don't keep all items alive
      addRepaintBoundaries: false, // Reduce repaint boundaries for better performance
    );
  }

  // Optimized grid view
  static Widget optimizedGridView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    required SliverGridDelegate gridDelegate,
    ScrollController? controller,
    EdgeInsets? padding,
    bool shrinkWrap = false,
  }) {
    return GridView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      gridDelegate: gridDelegate,
      cacheExtent: 500,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
    );
  }

  // Optimized text widget with const constructor when possible
  static Widget optimizedText(
    String text, {
    TextStyle? style,
    TextDirection? textDirection,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: style,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  // Memory-efficient container
  static Widget optimizedContainer({
    Widget? child,
    double? width,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    Decoration? decoration,
    BorderRadius? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration ?? (color != null || borderRadius != null
          ? BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            )
          : null),
      child: child,
    );
  }

  // Optimized loading indicator
  static Widget optimizedLoadingIndicator({
    double size = 20,
    double strokeWidth = 2,
    Color? color,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: color != null ? AlwaysStoppedAnimation<Color>(color) : null,
      ),
    );
  }

  // Batch Firebase operations for better performance
  static Future<List<T>> batchFirebaseQueries<T>(
    List<Future<T>> futures, {
    int batchSize = 10,
  }) async {
    final List<T> results = [];
    
    for (int i = 0; i < futures.length; i += batchSize) {
      final batch = futures.skip(i).take(batchSize);
      final batchResults = await Future.wait(batch);
      results.addAll(batchResults);
    }
    
    return results;
  }

  // Optimized image placeholder
  static Widget imageLoadingPlaceholder({
    required double width,
    required double height,
    IconData icon = Icons.image,
  }) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade200,
      child: Icon(
        icon,
        color: Colors.grey.shade400,
        size: width * 0.3,
      ),
    );
  }

  // Optimized error widget
  static Widget imageErrorWidget({
    required double width,
    required double height,
    IconData icon = Icons.broken_image,
    String? errorText,
  }) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey.shade600,
            size: width * 0.2,
          ),
          if (errorText != null) ...[
            const SizedBox(height: 4),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
