import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../header.dart';
import '../../language_provider.dart';
import '../../models/administrative_unit_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
}
