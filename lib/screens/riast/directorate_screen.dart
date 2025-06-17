import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../header.dart';
import '../../language_provider.dart';
import '../../services/firebase_cache_service.dart';
import '../../models/administrative_unit_model.dart';
import 'administration_detail_screen.dart';

class DirectorateScreen extends StatefulWidget {
  const DirectorateScreen({super.key});

  static const Color bgColor = Color(0xFFE1F5FE);

  @override
  State<DirectorateScreen> createState() => _DirectorateScreenState();
}

class _DirectorateScreenState extends State<DirectorateScreen> {
  @override
  void initState() {
    super.initState();
    _enableOfflinePersistence();
  }

  Future<void> _enableOfflinePersistence() async {
    try {
      // Enable offline persistence for Firebase using new method
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      debugPrint('Firebase offline persistence enabled');
    } catch (e) {
      debugPrint('Error enabling offline persistence: $e');
      // Persistence might already be enabled
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: DirectorateScreen.bgColor,
        body: DirectorateContent(),
      ),
    );
  }
}

class DirectorateContent extends StatelessWidget {
  const DirectorateContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Column(
          children: [
            CustomHeader(
              userName: languageProvider.getLocalizedString('guest_user'),
              bannerImagePath: 'images/kdr_logo.png',
              fullText: languageProvider.getLocalizedString('directorate_title'),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                key: ValueKey(languageProvider.currentLanguage), // Rebuild when language changes
                stream: FirebaseCacheService.instance.getAdministrativeUnitsStreamByLanguage(languageProvider.currentLanguage),
                builder: (context, snapshot) {
                  debugPrint('Connection State: ${snapshot.connectionState}');
                  debugPrint('Has Data: ${snapshot.hasData}');
                  debugPrint('Has Error: ${snapshot.hasError}');
                  debugPrint('Current Language: ${languageProvider.currentLanguage}');

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            languageProvider.getLocalizedString('loading_data'),
                            style: TextStyle(
                              fontFamily: languageProvider.getFontFamily(),
                              fontSize: 16,
                            ),
                            textDirection: languageProvider.getTextDirection(),
                          ),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    debugPrint('Error: ${snapshot.error}');
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${languageProvider.getLocalizedString('administration_error')}: ${snapshot.error}',
                            style: TextStyle(
                              fontFamily: languageProvider.getFontFamily(),
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: languageProvider.getTextDirection(),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              (context as Element).markNeedsBuild();
                            },
                            child: Text(
                              languageProvider.getLocalizedString('retry_button'),
                              style: TextStyle(fontFamily: languageProvider.getFontFamily()),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    debugPrint('No data in snapshot');
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_open,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            languageProvider.getLocalizedString('no_administration_data'),
                            style: TextStyle(
                              fontFamily: languageProvider.getFontFamily(),
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: languageProvider.getTextDirection(),
                          ),
                        ],
                      ),
                    );
                  }

                  final administrations = snapshot.data!.docs;
                  debugPrint('Found ${administrations.length} administrative units');

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate responsive grid parameters
                        final screenWidth = constraints.maxWidth;
                        final crossAxisCount = screenWidth > 600 ? 3 : 2;
                        final childAspectRatio = screenWidth > 600 ? 0.8 : 0.7;

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: administrations.length,
                          itemBuilder: (context, index) {
                            final adminUnit = AdministrativeUnitModel.fromFirestore(administrations[index]);

                            return _buildAdministrationCard(
                              context,
                              adminUnit,
                              languageProvider,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAdministrationCard(
    BuildContext context,
    AdministrativeUnitModel adminUnit,
    LanguageProvider languageProvider,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdministrationDetailScreen(
                adminUnit: adminUnit,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo/Image
              Container(
                width: 60, // Reduced size
                height: 60, // Reduced size
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade50,
                ),
                child: adminUnit.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          adminUnit.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.business,
                              size: 30, // Reduced icon size
                              color: Color(0xFF0D3B66),
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.business,
                        size: 30, // Reduced icon size
                        color: Color(0xFF0D3B66),
                      ),
              ),

              const SizedBox(height: 8), // Reduced spacing

              // Administration Name
              Flexible(
                child: Text(
                  adminUnit.getLocalizedName(languageProvider),
                  style: TextStyle(
                    fontSize: 14, // Reduced font size
                    fontWeight: FontWeight.bold,
                    fontFamily: languageProvider.getFontFamily(),
                    color: const Color(0xFF0D3B66),
                  ),
                  textAlign: TextAlign.center,
                  textDirection: languageProvider.getTextDirection(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 6), // Reduced spacing

              // Director
              Flexible(
                child: Text(
                  adminUnit.getLocalizedDirectorWithLabel(languageProvider),
                  style: TextStyle(
                    fontSize: 12, // Reduced font size
                    fontFamily: languageProvider.getFontFamily(),
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: languageProvider.getTextDirection(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 6), // Reduced spacing

              // Description preview
              Flexible(
                child: Text(
                  adminUnit.getShortDescription(languageProvider),
                  style: TextStyle(
                    fontSize: 10, // Reduced font size
                    fontFamily: languageProvider.getFontFamily(),
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: languageProvider.getTextDirection(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 8), // Fixed spacing instead of Spacer

              // View Details Button
              Container(
                width: double.infinity,
                height: 28, // Reduced height
                decoration: BoxDecoration(
                  color: const Color(0xFF0D3B66),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    languageProvider.getLocalizedString('view_details'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10, // Reduced font size
                      fontFamily: languageProvider.getFontFamily(),
                      fontWeight: FontWeight.w500,
                    ),
                    textDirection: languageProvider.getTextDirection(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
