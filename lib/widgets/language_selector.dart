import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';

class LanguageSelector extends StatelessWidget {
  final bool showLabel;
  final bool compact;

  const LanguageSelector({
    Key? key,
    this.showLabel = true,
    this.compact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return PopupMenuButton<String>(
          icon: Container(
            padding: EdgeInsets.all(compact ? 6 : 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language,
                  color: Colors.blue.shade700,
                  size: compact ? 16 : 20,
                ),
                if (showLabel && !compact) ...[
                  const SizedBox(width: 4),
                  Text(
                    languageProvider.getLanguageDisplayName(languageProvider.currentLanguage),
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: languageProvider.getFontFamily(),
                    ),
                    textDirection: languageProvider.getTextDirection(),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue.shade700,
                    size: 16,
                  ),
                ],
              ],
            ),
          ),
          onSelected: (String languageCode) {
            languageProvider.changeLanguage(languageCode);
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'ps',
              child: _buildLanguageItem(
                languageProvider.getLocalizedString('pashto'),
                'ps',
                languageProvider.currentLanguage,
              ),
            ),
            PopupMenuItem<String>(
              value: 'fa',
              child: _buildLanguageItem(
                languageProvider.getLocalizedString('dari'),
                'fa',
                languageProvider.currentLanguage,
              ),
            ),
            PopupMenuItem<String>(
              value: 'en',
              child: _buildLanguageItem(
                languageProvider.getLocalizedString('english'),
                'en',
                languageProvider.currentLanguage,
              ),
            ),
            PopupMenuItem<String>(
              value: 'kdru',
              child: _buildLanguageItem(
                languageProvider.getLocalizedString('kdru'),
                'kdru',
                languageProvider.currentLanguage,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageItem(String name, String code, String currentLanguage) {
    final isSelected = code == currentLanguage;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.blue.shade700 : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontFamily: _getFontFamily(code),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getFontFamily(String languageCode) {
    switch (languageCode) {
      case 'ps':
      case 'fa':
      case 'kdru':
        return 'pashto';
      case 'en':
        return 'Roboto';
      default:
        return 'pashto';
    }
  }
}
