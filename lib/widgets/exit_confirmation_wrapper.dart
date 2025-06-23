import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';

class ExitConfirmationWrapper extends StatelessWidget {
  final Widget child;
  final bool enableExitConfirmation;

  const ExitConfirmationWrapper({
    Key? key,
    required this.child,
    this.enableExitConfirmation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!enableExitConfirmation) {
      return child;
    }

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        return WillPopScope(
          onWillPop: () => _showExitConfirmationDialog(context, languageProvider),
          child: child,
        );
      },
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context, LanguageProvider languageProvider) async {
    // Check if we're on the root route (home screen)
    final isRootRoute = ModalRoute.of(context)?.isFirst ?? false;
    
    // If not on root route, allow normal back navigation
    if (!isRootRoute) {
      return true;
    }

    // If on root route, show exit confirmation
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.exit_to_app,
                color: Colors.red.shade600,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  languageProvider.getLocalizedString('exit_app'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageProvider.getFontFamily(),
                    color: Colors.red.shade600,
                  ),
                  textDirection: languageProvider.getTextDirection(),
                ),
              ),
            ],
          ),
          content: Text(
            languageProvider.getLocalizedString('exit_app_confirmation'),
            style: TextStyle(
              fontSize: 16,
              fontFamily: languageProvider.getFontFamily(),
              color: Colors.grey.shade700,
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                languageProvider.getLocalizedString('cancel'),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: languageProvider.getFontFamily(),
                  color: Colors.grey.shade600,
                ),
                textDirection: languageProvider.getTextDirection(),
              ),
            ),
            
            // Exit Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                SystemNavigator.pop(); // Exit the app
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                languageProvider.getLocalizedString('exit'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: languageProvider.getFontFamily(),
                ),
                textDirection: languageProvider.getTextDirection(),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }
}
