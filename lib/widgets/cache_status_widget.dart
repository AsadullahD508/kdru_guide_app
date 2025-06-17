import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';

class CacheStatusWidget extends StatelessWidget {
  final DocumentSnapshot? document;
  final QuerySnapshot? query;
  final bool showDetails;

  const CacheStatusWidget({
    Key? key,
    this.document,
    this.query,
    this.showDetails = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (document == null && query == null) return const SizedBox.shrink();

    final languageProvider = Provider.of<LanguageProvider>(context);
    
    bool isFromCache;
    bool hasPendingWrites;
    int? docCount;

    if (document != null) {
      isFromCache = document!.metadata.isFromCache;
      hasPendingWrites = document!.metadata.hasPendingWrites;
    } else {
      isFromCache = query!.metadata.isFromCache;
      hasPendingWrites = query!.metadata.hasPendingWrites;
      docCount = query!.docs.length;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isFromCache ? Colors.orange.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFromCache ? Colors.orange.shade300 : Colors.green.shade300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isFromCache ? Icons.offline_bolt : Icons.cloud_done,
            color: isFromCache ? Colors.orange.shade700 : Colors.green.shade700,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isFromCache 
                      ? languageProvider.getLocalizedString('loaded_from_cache')
                      : languageProvider.getLocalizedString('loaded_from_server'),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: languageProvider.getFontFamily(),
                    color: isFromCache ? Colors.orange.shade800 : Colors.green.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: languageProvider.getTextDirection(),
                ),
                if (showDetails && docCount != null)
                  Text(
                    '${languageProvider.getLocalizedString('documents_count')}: $docCount',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: languageProvider.getFontFamily(),
                      color: Colors.grey.shade600,
                    ),
                    textDirection: languageProvider.getTextDirection(),
                  ),
              ],
            ),
          ),
          if (hasPendingWrites) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.sync,
              color: Colors.blue.shade600,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              languageProvider.getLocalizedString('syncing'),
              style: TextStyle(
                fontSize: 10,
                fontFamily: languageProvider.getFontFamily(),
                color: Colors.blue.shade600,
              ),
              textDirection: languageProvider.getTextDirection(),
            ),
          ],
        ],
      ),
    );
  }
}

class SimpleCacheStatusWidget extends StatelessWidget {
  final bool isFromCache;
  final bool hasPendingWrites;

  const SimpleCacheStatusWidget({
    Key? key,
    required this.isFromCache,
    this.hasPendingWrites = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isFromCache ? Colors.orange.shade100 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFromCache ? Colors.orange.shade300 : Colors.green.shade300,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFromCache ? Icons.offline_bolt : Icons.wifi,
            color: isFromCache ? Colors.orange.shade700 : Colors.green.shade700,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            isFromCache 
                ? languageProvider.getLocalizedString('offline')
                : languageProvider.getLocalizedString('online'),
            style: TextStyle(
              fontSize: 10,
              fontFamily: languageProvider.getFontFamily(),
              color: isFromCache ? Colors.orange.shade800 : Colors.green.shade800,
              fontWeight: FontWeight.w500,
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          if (hasPendingWrites) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.sync,
              color: Colors.blue.shade600,
              size: 10,
            ),
          ],
        ],
      ),
    );
  }
}

class LoadingWithCacheWidget extends StatelessWidget {
  final String? message;

  const LoadingWithCacheWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message ?? languageProvider.getLocalizedString('loading_data'),
            style: TextStyle(
              fontFamily: languageProvider.getFontFamily(),
              fontSize: 16,
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          const SizedBox(height: 8),
          Text(
            languageProvider.getLocalizedString('loading_from_cache_if_available'),
            style: TextStyle(
              fontFamily: languageProvider.getFontFamily(),
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textDirection: languageProvider.getTextDirection(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ErrorWithRetryWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  final VoidCallback? onClearCache;

  const ErrorWithRetryWidget({
    Key? key,
    required this.error,
    this.onRetry,
    this.onClearCache,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              languageProvider.getLocalizedString('error_occurred'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: languageProvider.getFontFamily(),
              ),
              textDirection: languageProvider.getTextDirection(),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontFamily: languageProvider.getFontFamily(),
              ),
              textDirection: languageProvider.getTextDirection(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onRetry != null)
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(
                      languageProvider.getLocalizedString('retry'),
                      style: TextStyle(
                        fontFamily: languageProvider.getFontFamily(),
                      ),
                    ),
                  ),
                if (onRetry != null && onClearCache != null)
                  const SizedBox(width: 16),
                if (onClearCache != null)
                  OutlinedButton.icon(
                    onPressed: onClearCache,
                    icon: const Icon(Icons.clear_all),
                    label: Text(
                      languageProvider.getLocalizedString('clear_cache'),
                      style: TextStyle(
                        fontFamily: languageProvider.getFontFamily(),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
