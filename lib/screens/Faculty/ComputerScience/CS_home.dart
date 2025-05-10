import 'package:flutter/material.dart';
import 'package:Kdru_Guide_app/header.dart';
import '../../../widgets/buttom_header.dart';
import './Cs_Department/CS_department.dart';
// Make sure this file exists

class CsFaculty extends StatefulWidget {
  const CsFaculty({super.key});

  @override
  _CsFacultyState createState() => _CsFacultyState();
}

class _CsFacultyState extends State<CsFaculty> {
  int selectedIndex = 0;

  // Method to handle bottom navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    // You can navigate to different screens based on the selected index.
    // For example:
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const CsFaculty()), // Replace with the appropriate screen for this index
      );
    }
    // Add other navigation cases here for more items
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        children: [
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'کمپیوټر ساینس پوهنځي ته ښه راغلاست',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Title with PNG Icon
                      Row(
                        children: [
                          Image.asset(
                            'images/kdr_logo.png', // Icon for the department
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'کمپیوټر ساینس پوهنځی',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'pashto',
                              color: Color(0xFF0D3B66),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 32),
                      // History of Faculty Section with Icon
                      Row(
                        children: [
                          Image.asset(
                            'images/hospital.png', // Icon for history section
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'تاریخچه پوهنځی',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'pashto',
                              color: Color(0xFF0D3B66),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'د کمپیوټر ساینس پوهنځی په ۱۳۹۳ هجري شمسي کال کې تاسیس شو...',
                          style: TextStyle(
                            fontFamily: 'pashto',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(child: _buildStatCard('دیپارتمینت', '4')),
                          const SizedBox(width: 12),
                          Expanded(child: _buildStatCard('استادان', '6')),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'لرلید',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'pashto',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'د یو معیاري، نوښتګر او نړیوالې کچې کمپیوټر ساینس پوهنځی جوړول...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'pashto',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      _buildVisionSection(),
                      const SizedBox(height: 24),
                      _buildMissionSection(),
                      const SizedBox(height: 24),
                      _buildGallerySection(), // Gallery section moved under mission
                      const SizedBox(height: 40),
                      _buildDepartmentsSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: selectedIndex,
      ),
    );
  }

  static Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black, fontFamily: 'pashto')),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B66),
              fontFamily: 'pashto',
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildVisionSection() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1607237138185-eedd9c632b0b?...'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black54,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/view.png', width: 60, height: 60),
              const Text('لرلید',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'pashto')),
              const SizedBox(height: 12),
              const Text(
                'د یو معیاري، نوښتګر او نړیوالې کچې کمپیوټر ساینس پوهنځی جوړول...',
                style: TextStyle(
                    fontSize: 16, color: Colors.white70, fontFamily: 'pashto'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildMissionSection() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/achieve.png', width: 60, height: 60),
            const Text('ریسالت',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'pashto')),
            const SizedBox(height: 12),
            const Text(
              'د کمپیوټر ساینس پوهنځی د تدریس، څیړنې او نوښت له لارې...',
              style: TextStyle(
                  fontSize: 16, color: Colors.white70, fontFamily: 'pashto'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildGallerySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ګالري',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
            fontFamily: 'pashto',
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 6, // Number of images
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('images/kdr.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  static Widget _buildDepartmentsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('څانګي',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
                fontFamily: 'pashto')),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ComputerScienceDepartment(
                          departmentName: 'عمومی',
                        )),
              );
            },
            child: const Text(
              'کمپیوټر ساینس',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'pashto',
                color: Color(0xFF0D3B66),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
