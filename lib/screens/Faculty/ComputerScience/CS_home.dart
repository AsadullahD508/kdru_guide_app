import 'package:flutter/material.dart';
import 'package:Kdru_Guide_app/header.dart';
import '../../../widgets/buttom_header.dart';
import './Cs_Department/CS_department.dart';

class CsFaculty extends StatefulWidget {
  const CsFaculty({super.key});

  @override
  _CsFacultyState createState() => _CsFacultyState();
}

class _CsFacultyState extends State<CsFaculty> {
  int selectedIndex = 0;
  bool showAllImages = false;
  bool showAllDepartments = false;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CsFaculty()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        children: [
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/computerscience.jpg',
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
                      Row(
                        children: [
                          Image.asset('images/kdr_logo.png',
                              width: 20, height: 20),
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
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Image.asset('images/folder.png',
                              width: 40, height: 40),
                          const SizedBox(width: 12),
                          const Text(
                            ' دپوهنځی تاریخچه',
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
                          Expanded(
                            child: _buildStatCard(
                              'دیپارتمینت',
                              '4',
                              'images/department (2).png',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'استادان',
                              '6',
                              'images/organization-structure.png',
                            ),
                          ),
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
                      const SizedBox(height: 40),
                      _buildDepartmentsSection(),
                      const SizedBox(height: 40),
                      _buildGallerySection(),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              showAllImages = !showAllImages;
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: Text(
                            showAllImages
                                ? 'کمه انځورونه ښکاره کړه'
                                : 'نور انځورونه ښکاره کړه',
                            style: const TextStyle(fontFamily: 'pashto'),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF759FC6),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ✅ New Button for Teachers Info
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Replace with actual navigation
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('استادانو ته انتقال...'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.school),
                          label: const Text(
                            'د استادانو معلومات',
                            style: TextStyle(fontFamily: 'pashto'),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A90E2),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
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

  static Widget _buildStatCard(String title, String value, String iconPath) {
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
          Image.asset(iconPath, width: 32, height: 32),
          const SizedBox(height: 12),
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
          image: AssetImage('images/kdr.jpg'),
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

  Widget _buildGallerySection() {
    List<String> images = List.generate(6, (index) => 'images/kdr.jpg');
    int imageCount = showAllImages ? images.length : 2;

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
          itemCount: imageCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDepartmentsSection() {
    List<String> departments = ['عمومی'];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('څانګي',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D3B66),
                  fontFamily: 'pashto')),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: departments
                .take(showAllDepartments ? departments.length : 1)
                .map((department) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ComputerScienceDepartment(
                        departmentName: department,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    department,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'pashto',
                      color: Color(0xFF0D3B66),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ComputerScienceDepartment(
                      departmentName: 'عمومی',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text(
                'د څانګي لیدل',
                style: TextStyle(fontFamily: 'pashto'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF759FC6),
                foregroundColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
