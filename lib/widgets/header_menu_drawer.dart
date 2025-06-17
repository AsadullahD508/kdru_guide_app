import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';

class HeaderMenu extends StatelessWidget {
  const HeaderMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showProfileMenu(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade300),
        ),
        child: Icon(
          Icons.menu,
          color: Colors.blue.shade700,
          size: 20,
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildProfileMenuSheet(context),
    );
  }

  Widget _buildProfileMenuSheet(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade400,
                      Colors.purple.shade400,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'images/kdr_logo.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.school,
                              size: 40,
                              color: Colors.blue.shade700,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      languageProvider.getLocalizedString('kandahar_university'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textDirection: languageProvider.getTextDirection(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'info@kdru.edu.af',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildProfileMenuItem(
                      icon: Icons.info_outline,
                      title: languageProvider.getLocalizedString('about_app'),
                      onTap: () {
                        Navigator.pop(context);
                        _showAboutDialog(context);
                      },
                      languageProvider: languageProvider,
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),

                    // Language Selection Section
                    Text(
                      languageProvider.getLocalizedString('select_language'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        fontFamily: languageProvider.getFontFamily(),
                      ),
                      textDirection: languageProvider.getTextDirection(),
                    ),
                    const SizedBox(height: 12),

                    _buildLanguageOption('ps', languageProvider, context: context),
                    _buildLanguageOption('fa', languageProvider, context: context),
                    _buildLanguageOption('en', languageProvider, context: context),
                    
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required LanguageProvider languageProvider,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.blue.shade700,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: languageProvider.getFontFamily(),
            color: Colors.grey.shade800,
          ),
          textDirection: languageProvider.getTextDirection(),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String languageCode, LanguageProvider languageProvider, {required BuildContext context}) {
    final isSelected = languageCode == languageProvider.currentLanguage;
    String languageName;

    switch (languageCode) {
      case 'ps':
        languageName = languageProvider.getLocalizedString('pashto');
        break;
      case 'fa':
        languageName = languageProvider.getLocalizedString('dari');
        break;
      case 'en':
        languageName = languageProvider.getLocalizedString('english');
        break;
    
      default:
        languageName = languageProvider.getLocalizedString('pashto');
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade400,
          size: 20,
        ),
        title: Text(
          languageName,
          style: TextStyle(
            fontSize: 14,
            fontFamily: _getFontFamily(languageCode),
            color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          textDirection: languageProvider.getTextDirection(),
        ),
        onTap: () {
          languageProvider.changeLanguage(languageCode);
          Navigator.pop(context);
          _showLanguageChangeSnackBar(context, languageCode);
        },
        dense: true,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  String _getFontFamily(String languageCode) {
    switch (languageCode) {
      case 'ps':
      case 'fa':
     
        
      case 'en':
        return 'Roboto';
      default:
        return 'pashto';
    }
  }

  void _showLanguageChangeSnackBar(BuildContext context, String languageCode) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    String messageKey;
    switch (languageCode) {
      case 'ps':
        messageKey = 'language_changed_to_pashto';
        break;
      case 'fa':
        messageKey = 'language_changed_to_dari';
        break;
      case 'en':
        messageKey = 'language_changed_to_english';
        break;
      
      default:
        messageKey = 'language_changed_to_pashto';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          languageProvider.getLocalizedString(messageKey),
          style: TextStyle(fontFamily: languageProvider.getFontFamily()),
          textDirection: languageProvider.getTextDirection(),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            languageProvider.getLocalizedString('about_app'),
            style: TextStyle(fontFamily: languageProvider.getFontFamily()),
            textDirection: languageProvider.getTextDirection(),
          ),
          content: Text(
            languageProvider.getLocalizedString('about_app_description'),
            style: TextStyle(fontFamily: languageProvider.getFontFamily()),
            textDirection: languageProvider.getTextDirection(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                languageProvider.getLocalizedString('ok'),
                style: TextStyle(fontFamily: languageProvider.getFontFamily()),
              ),
            ),
          ],
        );
      },
    );
  }
}