import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

/// A test widget to demonstrate responsive design functionality
class ResponsiveTestWidget extends StatelessWidget {
  const ResponsiveTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Design Test'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: ResponsiveUtils.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen size indicator
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getScreenTypeColor(context),
                borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
              ),
              child: Column(
                children: [
                  Text(
                    'Current Screen Type: ${_getScreenTypeName(context)}',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 18),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Screen Width: ${context.screenWidth.toInt()}px',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 20)),
            
            // Responsive grid
            Text(
              'Responsive Grid Layout',
              style: TextStyle(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 20),
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveUtils.getGridCrossAxisCount(context),
                mainAxisSpacing: ResponsiveUtils.getResponsiveSpacing(context),
                crossAxisSpacing: ResponsiveUtils.getResponsiveSpacing(context),
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: ResponsiveUtils.getCardElevation(context),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 16),
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                );
              },
            ),
            
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 20)),
            
            // Responsive cards
            Text(
              'Responsive Cards',
              style: TextStyle(
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 20),
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
            
            Row(
              children: [
                Expanded(
                  child: _buildTestCard(context, 'Mobile First', Colors.green),
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
                Expanded(
                  child: _buildTestCard(context, 'Responsive', Colors.orange),
                ),
              ],
            ),
            
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
            
            // Breakpoint information
            Container(
              width: double.infinity,
              padding: ResponsiveUtils.getResponsivePadding(context),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Breakpoint Information',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Mobile: < ${ResponsiveUtils.mobileBreakpoint}px'),
                  Text('Tablet: ${ResponsiveUtils.mobileBreakpoint}px - ${ResponsiveUtils.tabletBreakpoint}px'),
                  Text('Desktop: > ${ResponsiveUtils.tabletBreakpoint}px'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTestCard(BuildContext context, String title, Color color) {
    return Container(
      height: context.responsiveValue(
        mobile: 120.0,
        tablet: 140.0,
        desktop: 160.0,
      ),
      padding: ResponsiveUtils.getResponsivePadding(context),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 16),
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  
  String _getScreenTypeName(BuildContext context) {
    if (context.isMobile) return 'Mobile';
    if (context.isTablet) return 'Tablet';
    if (context.isDesktop) return 'Desktop';
    return 'Unknown';
  }
  
  Color _getScreenTypeColor(BuildContext context) {
    if (context.isMobile) return Colors.green;
    if (context.isTablet) return Colors.orange;
    if (context.isDesktop) return Colors.blue;
    return Colors.grey;
  }
}
