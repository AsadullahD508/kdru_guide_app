import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home.dart';
import '../screens/Faculty/facultycard.dart';
import '../screens/home_screen.dart';
import '../language_provider.dart';
import '../utils/responsive_utils.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Directionality(
          textDirection: languageProvider.getTextDirection(),
          child: BottomAppBar(
            height: context.responsiveValue(
              mobile: 75,
              tablet: 80,
              desktop: 85,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                      Icons.home,
                      0,
                      languageProvider.getLocalizedString('home'),
                      context,
                      languageProvider),
                  _buildNavItem(
                      Icons.account_balance_rounded,
                      1,
                      languageProvider.getLocalizedString('faculties'),
                      context,
                      languageProvider),
                  _buildNavItem(
                      Icons.school,
                      2,
                      languageProvider.getLocalizedString('university_name'),
                      context,
                      languageProvider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label,
      BuildContext context, LanguageProvider languageProvider) {
    bool isSelected = index == selectedIndex;

    final iconSize = context.responsiveValue(
      mobile: 20.0,
      tablet: 22.0,
      desktop: 24.0,
    );

    final fontSize = context.responsiveValue(
      mobile: 12.0,
      tablet: 14.0,
      desktop: 15.0,
    );

    return Expanded(
      child: GestureDetector(
        onTap: () {
          onItemTapped(index);

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const FirstHomescreen(),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const FacultyCard(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Homescreen(selectedIndex: 2),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: isSelected
                      ? Matrix4.translationValues(0, -1, 0)
                      : Matrix4.identity(),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.lightBlue : Colors.black,
                    size: iconSize,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                flex: 3,
                child: Container(
                  constraints: const BoxConstraints(minHeight: 28),
                  alignment: Alignment.center,
                  child: ResponsiveUtils.createOverflowSafeText(
                    label,
                    context: context,
                    currentLanguage: languageProvider.currentLanguage,
                    style: TextStyle(
                      color: isSelected ? Colors.lightBlue : Colors.black,
                      fontFamily: languageProvider.getFontFamily(),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      height: 1.0,
                    ),
                    fontSize: fontSize,
                    textDirection: languageProvider.getTextDirection(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
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
