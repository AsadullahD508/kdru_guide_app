import 'package:Kdru_Guide_app/screens/riast/directorate_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'header.dart';
import 'package:Kdru_Guide_app/widgets/buttom_header.dart';
import 'language_provider.dart';
import 'utils/responsive_utils.dart';

class FirstHomescreen extends StatefulWidget {
  const FirstHomescreen({super.key});

  static const Color kPrimaryColor = Color(0xFF20C0C7);
  static const Color kBackgroundColor = Color(0xFFE5F7FE);

  @override
  State<FirstHomescreen> createState() => _FirstHomescreen();
}

class _FirstHomescreen extends State<FirstHomescreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FirstHomescreen.kBackgroundColor,
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: selectedIndex,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return CustomHeader(
                userName: languageProvider.getLocalizedString('guest_user'),
                bannerImagePath: 'images/kdr_logo.png',
                fullText:
                    languageProvider.getLocalizedString('welcome_message'),
              );
            },
          ),

          // Riyasat Qadari Button
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return Padding(
                padding: ResponsiveUtils.getResponsivePadding(
                  context,
                  mobile:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  tablet:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  desktop:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: _buildRiyasatQadariButton(languageProvider),
              );
            },
          ),

          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Center(
                  child: Text(
                    languageProvider.getLocalizedString('our_services'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: languageProvider.getFontFamily(),
                    ),
                    textDirection: languageProvider.getTextDirection(),
                  ),
                ),
              );
            },
          ),

          // 🔹 Main Page Content
          Expanded(
            child: _buildPage(selectedIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    if (index == 0) {
      return _buildHomeContent();
    } else if (index == 1) {
      return _buildHomeContent();
    } else if (index == 2) {
      return _buildHomeContent();
    }
    return const SizedBox();
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: ResponsiveUtils.getResponsivePadding(
              context,
              mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              tablet: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              desktop: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return _buildInfoCard(
                        title: languageProvider
                            .getLocalizedString('qadari_hospital'),
                        imagePath: 'images/hospital.png',
                        languageProvider: languageProvider,
                      );
                    },
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
                Expanded(
                  child: Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return _buildInfoCard(
                        title: languageProvider.getLocalizedString('hostel'),
                        imagePath: 'images/hostel (1).png',
                        languageProvider: languageProvider,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: ResponsiveUtils.getResponsivePadding(
              context,
              mobile: const EdgeInsets.symmetric(horizontal: 16),
              tablet: const EdgeInsets.symmetric(horizontal: 24),
              desktop: const EdgeInsets.symmetric(horizontal: 32),
            ),
            child: Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveUtils.getGridCrossAxisCount(
                      context,
                      mobile: 2,
                      tablet: 3,
                      desktop: 4,
                    ),
                    mainAxisSpacing:
                        ResponsiveUtils.getResponsiveSpacing(context),
                    crossAxisSpacing:
                        ResponsiveUtils.getResponsiveSpacing(context),
                    childAspectRatio: context.responsiveValue(
                      mobile: 1.2,
                      tablet: 1.1,
                      desktop: 1.0,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final policyTitleKeys = [
                      'laboratory',
                      'conference_hall',
                      'library',
                      'research_office',
                    ];
                    final policyImages = [
                      'images/experiment.png',
                      'images/hospital.png',
                      'images/hospital.png',
                      'images/seo.png',
                    ];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              policyImages[index],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              languageProvider
                                  .getLocalizedString(policyTitleKeys[index]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: languageProvider.getFontFamily(),
                              ),
                              textDirection:
                                  languageProvider.getTextDirection(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String imagePath,
    required LanguageProvider languageProvider,
  }) {
    return Container(
      height: context.responsiveValue(
        mobile: 120.0,
        tablet: 140.0,
        desktop: 160.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: ResponsiveUtils.getCardElevation(context),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: ResponsiveUtils.getResponsivePadding(
          context,
          mobile: const EdgeInsets.all(12.0),
          tablet: const EdgeInsets.all(16.0),
          desktop: const EdgeInsets.all(20.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: context.responsiveValue(
                  mobile: 60.0,
                  tablet: 70.0,
                  desktop: 80.0,
                ),
                height: context.responsiveValue(
                  mobile: 60.0,
                  tablet: 70.0,
                  desktop: 80.0,
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(
                        context,
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                      ),
                      fontWeight: FontWeight.bold,
                      fontFamily: languageProvider.getFontFamily(),
                    ),
                    textDirection: languageProvider.getTextDirection(),
                  ),
                  SizedBox(
                      height: ResponsiveUtils.getResponsiveSpacing(context,
                          mobile: 8)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiyasatQadariButton(LanguageProvider languageProvider) {
    return Container(
      width: double.infinity,
      height: context.responsiveValue(
        mobile: 80.0,
        tablet: 90.0,
        desktop: 100.0,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D3B66), Color(0xFF1E5F8B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: ResponsiveUtils.getCardElevation(context),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DirectorateScreen(),
              ),
            );
          },
          child: Padding(
            padding: ResponsiveUtils.getResponsivePadding(
              context,
              mobile: const EdgeInsets.all(16.0),
              tablet: const EdgeInsets.all(20.0),
              desktop: const EdgeInsets.all(24.0),
            ),
            child: Row(
              children: [
                Container(
                  width: context.responsiveValue(
                    mobile: 48.0,
                    tablet: 56.0,
                    desktop: 64.0,
                  ),
                  height: context.responsiveValue(
                    mobile: 48.0,
                    tablet: 56.0,
                    desktop: 64.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: context.responsiveValue(
                      mobile: 24.0,
                      tablet: 28.0,
                      desktop: 32.0,
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        languageProvider
                            .getLocalizedString('riyasat_qadari_title'),
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        languageProvider
                            .getLocalizedString('university_administration'),
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            mobile: 12,
                            tablet: 14,
                            desktop: 16,
                          ),
                          color: Colors.white.withOpacity(0.9),
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      ),
                    ],
                  ),
                ),
                Icon(
                  languageProvider.getTextDirection() == TextDirection.rtl
                      ? Icons.arrow_back_ios
                      : Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: context.responsiveValue(
                    mobile: 20.0,
                    tablet: 24.0,
                    desktop: 28.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
