import 'package:Kdru_Guide_app/widgets/header_menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'home.dart';
import 'language_provider.dart';
import 'utils/responsive_utils.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/teacher_search_screen.dart';

class CustomHeader extends StatefulWidget {
  final String userName;
  final String bannerImagePath;
  final String fullText;

  const CustomHeader({
    Key? key,
    required this.userName,
    required this.bannerImagePath,
    required this.fullText,
  }) : super(key: key);

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<Offset> _imageOffsetAnimation;

  String displayedText = "";
  int _currentLetterIndex = 0;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _imageOffsetAnimation =
        Tween<Offset>(begin: const Offset(3.0, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOut),
    );

    _imageController.forward();
    Future.delayed(const Duration(milliseconds: 300), _startTyping);
  }

  void _startTyping() {
    Future.delayed(const Duration(milliseconds: 60), () {
      if (mounted && _currentLetterIndex < widget.fullText.length) {
        setState(() {
          displayedText += widget.fullText[_currentLetterIndex];
          _currentLetterIndex++;
        });
        _startTyping();
      }
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  void _handleBackNavigation(
      BuildContext context, LanguageProvider languageProvider) {
    final navigator = Navigator.of(context);

    // Check if we can go back (there are pages in the navigation stack)
    if (navigator.canPop()) {
      // Check if we're specifically on the FirstHomescreen (main home page)
      final isOnMainHomePage = _isOnMainHomePage(context);

      if (isOnMainHomePage) {
        // Already on main home page, show message instead of navigating
        _showMainPageMessage(context, languageProvider);
      } else {
        // Normal back navigation - go to previous page
        navigator.pop();
      }
    } else {
      // Already on the first route, check if it's the main home page
      final isOnMainHomePage = _isOnMainHomePage(context);
      if (isOnMainHomePage) {
        _showMainPageMessage(context, languageProvider);
      } else {
        // If not on main home page but can't pop, just go back normally
        navigator.pop();
      }
    }
  }

  bool _isOnMainHomePage(BuildContext context) {
    // Get the current route
    final currentRoute = ModalRoute.of(context);

    // Check multiple conditions to identify the main home page
    final isFirstRoute = currentRoute?.isFirst == true;
    final routeName = currentRoute?.settings.name;

    final isHomeRoute =
        routeName == '/' || routeName == '/home' || routeName == null;

    bool isFirstHomescreen = false;
    try {
      context.findAncestorWidgetOfExactType<FirstHomescreen>();
      isFirstHomescreen = true;
    } catch (e) {
      isFirstHomescreen = false;
    }

    return isFirstRoute && (isHomeRoute || isFirstHomescreen);
  }

  void _showMainPageMessage(
      BuildContext context, LanguageProvider languageProvider) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.home,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                languageProvider.getLocalizedString('you_are_on_main_page'),
                textDirection: languageProvider.getTextDirection(),
                style: TextStyle(
                  fontFamily: languageProvider.getFontFamily(),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: languageProvider.getLocalizedString('ok'),
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Directionality(
          textDirection: languageProvider.getTextDirection(),
          child: Container(
            color: Colors.lightBlue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar Section
                _buildAppBar(context, languageProvider),

                // Main Header Content
                Padding(
                  padding: ResponsiveUtils.getResponsivePadding(context),
                  child: Column(
                    children: [
                      SizedBox(
                          height: ResponsiveUtils.getResponsiveSpacing(context,
                              mobile: 20)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        ResponsiveUtils.getResponsiveBorderRadius(context),
                  ),
                  padding: ResponsiveUtils.getResponsivePadding(
                    context,
                    mobile: const EdgeInsets.all(12),
                    tablet: const EdgeInsets.all(16),
                    desktop: const EdgeInsets.all(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<LanguageProvider>(
                              builder: (context, languageProvider, child) {
                                return Text(
                                  languageProvider
                                      .getLocalizedString('welcome_message'),
                                  textDirection:
                                      languageProvider.getTextDirection(),
                                  style: TextStyle(
                                    fontSize:
                                        ResponsiveUtils.getResponsiveFontSize(
                                      context,
                                      mobile: 14,
                                      tablet: 16,
                                      desktop: 18,
                                    ),
                                    color: Colors.black87,
                                    fontFamily:
                                        languageProvider.getFontFamily(),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: ResponsiveUtils.getResponsiveSpacing(context,
                              mobile: 8)),
                      Flexible(
                        flex: 1,
                        child: SlideTransition(
                          position: _imageOffsetAnimation,
                          child: _buildCircularImage(
                            widget.bannerImagePath,
                            context.responsiveValue(
                              mobile: 80.0,
                              tablet: 100.0,
                              desktop: 120.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Menu Button (moved from header)
              const HeaderMenu(),

              const SizedBox(width: 12),

              // User Avatar (moved from header) - Clickable
              GestureDetector(
                onTap: () => _navigateToProfile(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Center - University Name
              Expanded(
                child: Center(
                  child: Text(
                    languageProvider.getLocalizedString('university_name'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: languageProvider.getFontFamily(),
                    ),
                    textDirection: languageProvider.getTextDirection(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // Search Button
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
                tooltip: languageProvider.getLocalizedString('search'),
                onPressed: () => _navigateToSearch(context, languageProvider),
              ),

              // Back Button (moved from header)
              IconButton(
                icon: Icon(
                  languageProvider.getTextDirection() == TextDirection.rtl
                      ? Icons.arrow_forward
                      : Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
                tooltip: languageProvider.getLocalizedString('go_back'),
                onPressed: () => _handleBackNavigation(context, languageProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TeamProfilePage(),
      ),
    );
  }

  void _navigateToSearch(BuildContext context, LanguageProvider languageProvider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TeacherSearchScreen(),
      ),
    );
  }

  Widget _buildCircularImage(String imagePath, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: _buildImageContent(imagePath, size, size),
      ),
    );
  }

  Widget _buildImageContent(String imagePath, double width, double height) {
    // Check if it's a network URL (starts with http)
    if (imagePath.startsWith('http')) {
      return Hero(
        tag:
            'header_image_${imagePath.hashCode}_${width.toString()}_${height.toString()}',
        child: CachedNetworkImage(
          imageUrl: imagePath,
          width: width,
          height: height,
          fit: BoxFit.cover,
          memCacheWidth: (width * 2).round(),
          memCacheHeight: (height * 2).round(),
          placeholder: (context, url) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
          errorWidget: (context, url, error) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.grey,
              size: 30,
            ),
          ),
          fadeInDuration: const Duration(milliseconds: 200),
          fadeOutDuration: const Duration(milliseconds: 100),
        ),
      );
    } else {
      // Use asset image for local images
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to default asset image if asset fails
          return Image.asset(
            'images/kdr_logo.png',
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Final fallback if even the default asset fails
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 30,
                ),
              );
            },
          );
        },
      );
    }
  }
}
