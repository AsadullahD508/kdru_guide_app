import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  Widget _buildCategoryCard(String title, String emoji) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        //   FixedHeader(), Stays fixed at top
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildCategoryCard('Health', '🏥'),
                _buildCategoryCard('Home', '🏠'),
                _buildCategoryCard('Auto', '🚗'),
                _buildCategoryCard('Family', '👨‍👩‍👧‍👦'),
                _buildCategoryCard('Business', '💼'),
                _buildCategoryCard('Travel', '✈️'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
