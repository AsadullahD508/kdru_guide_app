import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kdru_guide_app/utils/responsive_utils.dart';

void main() {
  group('ResponsiveUtils Tests', () {
    
    // Helper function to create a BuildContext with specific screen size
    Widget createTestWidget(Size size) {
      return MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: size),
          child: const Scaffold(
            body: SizedBox(),
          ),
        ),
      );
    }

    group('Screen Size Detection', () {
      testWidgets('should detect mobile screen size correctly', (WidgetTester tester) async {
        const mobileSize = Size(360, 640); // Typical mobile size
        await tester.pumpWidget(createTestWidget(mobileSize));
        
        final context = tester.element(find.byType(SizedBox));
        
        // Test mobile detection
        expect(ResponsiveUtils.isMobile(context), isTrue);
        expect(ResponsiveUtils.isTablet(context), isFalse);
        expect(ResponsiveUtils.isDesktop(context), isFalse);
      });

      testWidgets('should detect tablet screen size correctly', (WidgetTester tester) async {
        const tabletSize = Size(768, 1024); // Typical tablet size
        await tester.pumpWidget(createTestWidget(tabletSize));
        
        final context = tester.element(find.byType(SizedBox));
        
        // Test tablet detection
        expect(ResponsiveUtils.isMobile(context), isFalse);
        expect(ResponsiveUtils.isTablet(context), isTrue);
        expect(ResponsiveUtils.isDesktop(context), isFalse);
      });

      testWidgets('should detect desktop screen size correctly', (WidgetTester tester) async {
        const desktopSize = Size(1920, 1080); // Typical desktop size
        await tester.pumpWidget(createTestWidget(desktopSize));
        
        final context = tester.element(find.byType(SizedBox));
        
        // Test desktop detection
        expect(ResponsiveUtils.isMobile(context), isFalse);
        expect(ResponsiveUtils.isTablet(context), isFalse);
        expect(ResponsiveUtils.isDesktop(context), isTrue);
      });
    });

    group('Responsive Values', () {
      testWidgets('should return correct responsive font sizes', (WidgetTester tester) async {
        // Test mobile
        const mobileSize = Size(360, 640);
        await tester.pumpWidget(createTestWidget(mobileSize));
        var context = tester.element(find.byType(SizedBox));
        
        final mobileFontSize = ResponsiveUtils.getResponsiveFontSize(
          context,
          mobile: 14,
          tablet: 16,
          desktop: 18,
        );
        expect(mobileFontSize, equals(14));

        // Test tablet
        const tabletSize = Size(768, 1024);
        await tester.pumpWidget(createTestWidget(tabletSize));
        context = tester.element(find.byType(SizedBox));
        
        final tabletFontSize = ResponsiveUtils.getResponsiveFontSize(
          context,
          mobile: 14,
          tablet: 16,
          desktop: 18,
        );
        expect(tabletFontSize, equals(16));

        // Test desktop
        const desktopSize = Size(1920, 1080);
        await tester.pumpWidget(createTestWidget(desktopSize));
        context = tester.element(find.byType(SizedBox));
        
        final desktopFontSize = ResponsiveUtils.getResponsiveFontSize(
          context,
          mobile: 14,
          tablet: 16,
          desktop: 18,
        );
        expect(desktopFontSize, equals(18));
      });

      testWidgets('should return correct responsive spacing', (WidgetTester tester) async {
        // Test mobile spacing
        const mobileSize = Size(360, 640);
        await tester.pumpWidget(createTestWidget(mobileSize));
        var context = tester.element(find.byType(SizedBox));
        
        final mobileSpacing = ResponsiveUtils.getResponsiveSpacing(context);
        expect(mobileSpacing, isA<double>());
        expect(mobileSpacing, greaterThan(0));

        // Test tablet spacing
        const tabletSize = Size(768, 1024);
        await tester.pumpWidget(createTestWidget(tabletSize));
        context = tester.element(find.byType(SizedBox));
        
        final tabletSpacing = ResponsiveUtils.getResponsiveSpacing(context);
        expect(tabletSpacing, isA<double>());
        expect(tabletSpacing, greaterThanOrEqualTo(mobileSpacing));

        // Test desktop spacing
        const desktopSize = Size(1920, 1080);
        await tester.pumpWidget(createTestWidget(desktopSize));
        context = tester.element(find.byType(SizedBox));
        
        final desktopSpacing = ResponsiveUtils.getResponsiveSpacing(context);
        expect(desktopSpacing, isA<double>());
        expect(desktopSpacing, greaterThanOrEqualTo(tabletSpacing));
      });

      testWidgets('should return correct grid cross axis count', (WidgetTester tester) async {
        // Test mobile grid
        const mobileSize = Size(360, 640);
        await tester.pumpWidget(createTestWidget(mobileSize));
        var context = tester.element(find.byType(SizedBox));
        
        final mobileGridCount = ResponsiveUtils.getGridCrossAxisCount(
          context,
          mobile: 2,
          tablet: 3,
          desktop: 4,
        );
        expect(mobileGridCount, equals(2));

        // Test tablet grid
        const tabletSize = Size(768, 1024);
        await tester.pumpWidget(createTestWidget(tabletSize));
        context = tester.element(find.byType(SizedBox));
        
        final tabletGridCount = ResponsiveUtils.getGridCrossAxisCount(
          context,
          mobile: 2,
          tablet: 3,
          desktop: 4,
        );
        expect(tabletGridCount, equals(3));

        // Test desktop grid
        const desktopSize = Size(1920, 1080);
        await tester.pumpWidget(createTestWidget(desktopSize));
        context = tester.element(find.byType(SizedBox));
        
        final desktopGridCount = ResponsiveUtils.getGridCrossAxisCount(
          context,
          mobile: 2,
          tablet: 3,
          desktop: 4,
        );
        expect(desktopGridCount, equals(4));
      });
    });

    group('Responsive Padding', () {
      testWidgets('should return correct responsive padding', (WidgetTester tester) async {
        const mobilePadding = EdgeInsets.all(8);
        const tabletPadding = EdgeInsets.all(12);
        const desktopPadding = EdgeInsets.all(16);

        // Test mobile padding
        const mobileSize = Size(360, 640);
        await tester.pumpWidget(createTestWidget(mobileSize));
        var context = tester.element(find.byType(SizedBox));
        
        final resultMobilePadding = ResponsiveUtils.getResponsivePadding(
          context,
          mobile: mobilePadding,
          tablet: tabletPadding,
          desktop: desktopPadding,
        );
        expect(resultMobilePadding, equals(mobilePadding));

        // Test tablet padding
        const tabletSize = Size(768, 1024);
        await tester.pumpWidget(createTestWidget(tabletSize));
        context = tester.element(find.byType(SizedBox));
        
        final resultTabletPadding = ResponsiveUtils.getResponsivePadding(
          context,
          mobile: mobilePadding,
          tablet: tabletPadding,
          desktop: desktopPadding,
        );
        expect(resultTabletPadding, equals(tabletPadding));

        // Test desktop padding
        const desktopSize = Size(1920, 1080);
        await tester.pumpWidget(createTestWidget(desktopSize));
        context = tester.element(find.byType(SizedBox));
        
        final resultDesktopPadding = ResponsiveUtils.getResponsivePadding(
          context,
          mobile: mobilePadding,
          tablet: tabletPadding,
          desktop: desktopPadding,
        );
        expect(resultDesktopPadding, equals(desktopPadding));
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle boundary screen sizes correctly', (WidgetTester tester) async {
        // Test exactly at mobile-tablet boundary
        const boundarySize = Size(600, 800);
        await tester.pumpWidget(createTestWidget(boundarySize));
        final context = tester.element(find.byType(SizedBox));
        
        // Should be either mobile or tablet, not both
        final isMobile = ResponsiveUtils.isMobile(context);
        final isTablet = ResponsiveUtils.isTablet(context);
        final isDesktop = ResponsiveUtils.isDesktop(context);
        
        expect(isMobile || isTablet || isDesktop, isTrue);
        expect((isMobile ? 1 : 0) + (isTablet ? 1 : 0) + (isDesktop ? 1 : 0), equals(1));
      });

      testWidgets('should handle very small screen sizes', (WidgetTester tester) async {
        const verySmallSize = Size(200, 300);
        await tester.pumpWidget(createTestWidget(verySmallSize));
        final context = tester.element(find.byType(SizedBox));
        
        // Should still work and classify as mobile
        expect(ResponsiveUtils.isMobile(context), isTrue);
        
        final fontSize = ResponsiveUtils.getResponsiveFontSize(
          context,
          mobile: 12,
          tablet: 14,
          desktop: 16,
        );
        expect(fontSize, equals(12));
      });

      testWidgets('should handle very large screen sizes', (WidgetTester tester) async {
        const veryLargeSize = Size(3840, 2160); // 4K
        await tester.pumpWidget(createTestWidget(veryLargeSize));
        final context = tester.element(find.byType(SizedBox));
        
        // Should still work and classify as desktop
        expect(ResponsiveUtils.isDesktop(context), isTrue);
        
        final fontSize = ResponsiveUtils.getResponsiveFontSize(
          context,
          mobile: 12,
          tablet: 14,
          desktop: 16,
        );
        expect(fontSize, equals(16));
      });
    });
  });
}
