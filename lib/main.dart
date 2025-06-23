import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'language_provider.dart';
import 'services/firebase_cache_service.dart';
import 'widgets/exit_confirmation_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCacheService.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Directionality(
            textDirection: languageProvider.getTextDirection(),
            child: MaterialApp(
              title: languageProvider.getLocalizedString('app_title'),
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: _getFontFamily(languageProvider.currentLanguage),
              ),
              home: languageProvider.isInitialized
                  ? const FirstHomescreen()
                  : const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
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


