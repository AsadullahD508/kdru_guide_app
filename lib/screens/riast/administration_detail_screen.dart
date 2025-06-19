import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../header.dart';
import '../../language_provider.dart';
import '../../models/administrative_unit_model.dart';
import '../../widgets/buttom_header.dart';

class AdministrationDetailScreen extends StatefulWidget {
  final AdministrativeUnitModel adminUnit;


  const AdministrationDetailScreen({
    super.key,
    required this.adminUnit,

  });

  static const Color bgColor = Color(0xFFE1F5FE);

  @override
  State<AdministrationDetailScreen> createState() => _AdministrationDetailScreenState();

}

class _AdministrationDetailScreenState extends State<AdministrationDetailScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: _onItemTapped,
          selectedIndex: 1,
        ),
        backgroundColor: AdministrationDetailScreen.bgColor,
        body: AdministrationDetailContent(
          adminUnit: widget.adminUnit,
        ),
      ),
    );
  }
}

class AdministrationDetailContent extends StatelessWidget {
  final AdministrativeUnitModel adminUnit;

  const AdministrationDetailContent({
    super.key,
    required this.adminUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Column(
          children: [
            CustomHeader(
              userName: languageProvider.getLocalizedString('guest_user'),
              bannerImagePath: 'images/kdr_logo.png',
              fullText: adminUnit.name.isNotEmpty
                  ? adminUnit.name
                  : languageProvider.getLocalizedString('administration_directorate'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Administration Name and Logo
                    _buildHeaderSection(languageProvider),

                    const SizedBox(height: 24),

                    // Director Info
                    if (adminUnit.director.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('director_label'),
                        adminUnit.director,
                        Icons.person,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // General Information
                    if (adminUnit.information.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('general_information'),
                        adminUnit.information,
                        Icons.info,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // Vision Section
                    if (adminUnit.vision.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('vision'),
                        adminUnit.vision,
                        Icons.visibility,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // Mission Section
                    if (adminUnit.mission.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('mission'),
                        adminUnit.mission,
                        Icons.flag,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // Goals Section
                    if (adminUnit.goals.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('goals'),
                        adminUnit.goals,
                        Icons.track_changes,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // Establishment Year
                    if (adminUnit.year.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('establishment_year'),
                        adminUnit.year,
                        Icons.calendar_today,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // Innovative Projects Section
                    if (adminUnit.innovativeProjects.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('innovative_projects'),
                        adminUnit.innovativeProjects,
                        Icons.lightbulb,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // International Relations Section
                    if (adminUnit.internationalRelations.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('international_relations'),
                        adminUnit.internationalRelations,
                        Icons.public,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // Quality Enhancement Section
                    if (adminUnit.qualityEnhancement.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('quality_enhancement'),
                        adminUnit.qualityEnhancement,
                        Icons.star,
                        languageProvider,
                      ),

                    const SizedBox(height: 24),

                    // Contact Information
                    if (adminUnit.contactInfo != null)
                      _buildContactSection(languageProvider),

                    const SizedBox(height: 24),

                    // Additional Information
                    if (adminUnit.description.isNotEmpty)
                      _buildInfoSection(
                        languageProvider.getLocalizedString('additional_information'),
                        adminUnit.description,
                        Icons.description,
                        languageProvider,
                      ),

                    const SizedBox(height: 32),

                    // Banner Section
                    _buildBannerSection(context, languageProvider),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeaderSection(LanguageProvider languageProvider) {
    return Column(
      children: [
        // Logo/Image
        if (adminUnit.imageUrl.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              adminUnit.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.business,
                    size: 60,
                    color: Color(0xFF0D3B66),
                  ),
                );
              },
            ),
          )
        else
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.business,
              size: 60,
              color: Color(0xFF0D3B66),
            ),
          ),

        const SizedBox(height: 16),

        // Administration Name
        Text(
          adminUnit.getLocalizedName(languageProvider),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: languageProvider.getFontFamily(),
            color: const Color(0xFF0D3B66),
          ),
          textAlign: TextAlign.center,
          textDirection: languageProvider.getTextDirection(),
        ),

        // Establishment Year
        if (adminUnit.year.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              adminUnit.getFormattedYear(languageProvider),
              style: TextStyle(
                fontSize: 16,
                fontFamily: languageProvider.getFontFamily(),
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
              textDirection: languageProvider.getTextDirection(),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection(String title, String content, IconData icon, LanguageProvider languageProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF0D3B66),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: languageProvider.getFontFamily(),
                color: const Color(0xFF0D3B66),
              ),
              textDirection: languageProvider.getTextDirection(),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blue.shade200,
              width: 1,
            ),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              fontFamily: languageProvider.getFontFamily(),
              height: 1.6,
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(LanguageProvider languageProvider) {
    if (adminUnit.contactInfo == null || adminUnit.contactInfo!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.contact_phone,
              color: Color(0xFF0D3B66),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              languageProvider.getLocalizedString('contact_information'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: languageProvider.getFontFamily(),
                color: const Color(0xFF0D3B66),
              ),
              textDirection: languageProvider.getTextDirection(),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blue.shade200,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: adminUnit.contactInfo!.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      entry.key.toLowerCase().contains('phone') ||
                      entry.key.toLowerCase().contains('mobile')
                          ? Icons.phone
                          : entry.key.toLowerCase().contains('email')
                              ? Icons.email
                              : Icons.info,
                      color: const Color(0xFF0D3B66),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${entry.key}: ${entry.value}',
                        style: TextStyle(
                          fontFamily: languageProvider.getFontFamily(),
                          fontSize: 14,
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerSection(BuildContext context, LanguageProvider languageProvider) {
    return Column(
      children: [
        // Banner Title
        Row(
          children: [
            const Icon(
              Icons.campaign,
              color: Color(0xFF0D3B66),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              languageProvider.getLocalizedString('banner_section'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: languageProvider.getFontFamily(),
                color: const Color(0xFF0D3B66),
              ),
              textDirection: languageProvider.getTextDirection(),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Banner Description
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blue.shade200,
              width: 1,
            ),
          ),
          child: Text(
            languageProvider.getLocalizedString('banner_description'),
            style: TextStyle(
              fontSize: 16,
              fontFamily: languageProvider.getFontFamily(),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            textDirection: languageProvider.getTextDirection(),
          ),
        ),

        const SizedBox(height: 20),

        // Banner Image from Database (organ field)
        if (adminUnit.organ.isNotEmpty)
          GestureDetector(
            onTap: () => _showExpandedImage(context, adminUnit.organ, languageProvider),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      adminUnit.organ,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                languageProvider.getLocalizedString('image_not_available'),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                textDirection: languageProvider.getTextDirection(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Expand icon overlay
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 8),
                Text(
                  languageProvider.getLocalizedString('image_not_available'),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: languageProvider.getFontFamily(),
                  ),
                  textDirection: languageProvider.getTextDirection(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _showExpandedImage(BuildContext context, String imageUrl, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              // Full screen image
              Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    languageProvider.getLocalizedString('loading'),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontFamily: languageProvider.getFontFamily(),
                                    ),
                                    textDirection: languageProvider.getTextDirection(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: Colors.red.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  languageProvider.getLocalizedString('image_not_available'),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: languageProvider.getFontFamily(),
                                  ),
                                  textDirection: languageProvider.getTextDirection(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // Close button
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              // Instructions text
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    languageProvider.getLocalizedString('image_viewer_instructions') ??
                    'Pinch to zoom • Drag to pan • Tap close button to exit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: languageProvider.getFontFamily(),
                    ),
                    textAlign: TextAlign.center,
                    textDirection: languageProvider.getTextDirection(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
