import 'package:flutter/material.dart';
import 'header.dart';
import 'package:Kdru_Guide_app/widgets/buttom_header.dart';

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
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'د کند هار پوهنتون ته شه راغلاست',
          ),

          // 🔹 "زموږ خدمتونه" Section Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Text(
                'زموږ خدمتونه',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'pashto',
                ),
              ),
            ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    title: 'قادری روغتون',
                    imagePath: 'images/hospital.png',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    title: 'لیلیه',
                    imagePath: 'images/hostel (1).png',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final policyTitles = [
                  'لابراتوار',
                  'د غونډو تالار',
                  'کتابتون',
                  'ریسرچ معاونیت',
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
                          policyTitles[index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'pashto')),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
