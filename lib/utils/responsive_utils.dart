import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
class ResponsiveUtils {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;
  static const double desktopBreakpoint = 1440;
  
  // Screen size categories
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }
  
  static bool isTabletOrDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileBreakpoint;
  }
  
  // Responsive values
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
  
  // Grid cross axis count based on screen size
  static int getGridCrossAxisCount(BuildContext context, {
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context, {
    EdgeInsets mobile = const EdgeInsets.all(16),
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? const EdgeInsets.all(24),
      desktop: desktop ?? const EdgeInsets.all(32),
    );
  }
  
  // Responsive font sizes
  static double getResponsiveFontSize(BuildContext context, {
    double mobile = 14,
    double? tablet,
    double? desktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile + 2,
      desktop: desktop ?? mobile + 4,
    );
  }

  // Language-aware responsive font size to prevent overflow
  static double getLanguageAwareFontSize(BuildContext context, {
    required String currentLanguage,
    double mobile = 14,
    double? tablet,
    double? desktop,
  }) {
    double baseFontSize = getResponsiveFontSize(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );

    // Reduce font size by 2 for English to prevent overflow
    if (currentLanguage == 'en') {
      return (baseFontSize - 2.0).clamp(8.0, double.infinity); // 2 points smaller for English, minimum 8
    }

    return baseFontSize;
  }

  // Adjust any font size based on language
  static double adjustFontSizeForLanguage(double fontSize, String currentLanguage) {
    if (currentLanguage == 'en') {
      // Reduce by exactly 2 points for English, but ensure minimum of 8
      return (fontSize - 2.0).clamp(8.0, double.infinity);
    }
    return fontSize;
  }
  
  // Responsive spacing
  static double getResponsiveSpacing(BuildContext context, {
    double mobile = 8,
    double? tablet,
    double? desktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile + 4,
      desktop: desktop ?? mobile + 8,
    );
  }
  
  // Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  // Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  
  // Check if screen is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
  
  // Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
  
  // Responsive container constraints
  static BoxConstraints getResponsiveConstraints(BuildContext context, {
    double? maxWidth,
    double? maxHeight,
  }) {
    final screenWidth = getScreenWidth(context);
    
    return BoxConstraints(
      maxWidth: maxWidth ?? (isDesktop(context) 
          ? screenWidth * 0.8 
          : isTablet(context) 
              ? screenWidth * 0.9 
              : screenWidth),
      maxHeight: maxHeight ?? double.infinity,
    );
  }
  
  // Responsive card elevation
  static double getCardElevation(BuildContext context) {
    return responsiveValue(
      context,
      mobile: 2.0,
      tablet: 4.0,
      desktop: 6.0,
    );
  }

  // Create overflow-safe text widget
  static Widget createOverflowSafeText(
    String text, {
    required BuildContext context,
    required String currentLanguage,
    TextStyle? style,
    TextDirection? textDirection,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize,
  }) {
    final safeFontSize = fontSize != null
        ? adjustFontSizeForLanguage(fontSize, currentLanguage)
        : getLanguageAwareFontSize(context, currentLanguage: currentLanguage);

    return Text(
      text,
      style: (style ?? const TextStyle()).copyWith(fontSize: safeFontSize),
      textDirection: textDirection,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }
  
  // Responsive border radius
  static BorderRadius getResponsiveBorderRadius(BuildContext context, {
    double mobile = 8,
    double? tablet,
    double? desktop,
  }) {
    final radius = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile + 2,
      desktop: desktop ?? mobile + 4,
    );
    return BorderRadius.circular(radius);
  }
}

/// Extension on BuildContext for easier access to responsive utilities
extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isTabletOrDesktop => ResponsiveUtils.isTabletOrDesktop(this);
  
  double get screenWidth => ResponsiveUtils.getScreenWidth(this);
  double get screenHeight => ResponsiveUtils.getScreenHeight(this);
  bool get isLandscape => ResponsiveUtils.isLandscape(this);
  
  EdgeInsets get safeAreaPadding => ResponsiveUtils.getSafeAreaPadding(this);
  
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) => ResponsiveUtils.responsiveValue(
    this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}
