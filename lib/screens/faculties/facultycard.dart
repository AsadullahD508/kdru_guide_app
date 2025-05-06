import 'package:flutter/material.dart';
import '../../widgets/custom_header.dart';

// Faculty screens
import 'agriculture/agriculture_faculty_screen.dart';
import 'computer_science/faculty_screen.dart';
import 'economics/Economics_screen.dart';
import 'education/Education_screen.dart';
import 'engineeringFaculty/EngFaculty.dart';
import 'medicine/medicine_faculty_screen.dart';

class FacultyCard extends StatelessWidget {
  const FacultyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'پوهنځیو', selectedIndex: 0),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'زموږ پوهنځۍ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D3B66),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: [
                          _buildFacultyCard(
                            context,
                            'کمپیوټر ساینس',
                            'د ټکنالوژۍ او نوښت په برخه کې زده کړې وړاندې کوي.',
                            'images/kdr_logo.png',
                            4,
                            28,
                            'images/kdr.jpg',
                            CsFaculty(),
                          ),
                          _buildFacultyCard(
                            context,
                            'انجنیرۍ',
                            'د انجنیري مختلفو برخو لکه ساختماني، برښنا، او اوبو او چاپېریال انجنیرۍ کې تخصص لري.',
                            'images/kdr_logo.png',
                            5,
                            32,
                            'images/kdr.jpg',
                            EngFaculty(),
                          ),
                          _buildFacultyCard(
                            context,
                            'طب',
                            'د روغتیا په برخه کې زده کړې وړاندې کوي.',
                            'images/kdr_logo.png',
                            6,
                            45,
                            'images/kdr.jpg',
                            MedFaculty(),
                          ),
                          _buildFacultyCard(
                            context,
                            'زراعت',
                            'د کرنې او زراعت په برخه کې زده کړې وړاندې کوي.',
                            'images/kdr_logo.png',
                            3,
                            20,
                            'images/kdr.jpg',
                            AgrFaculty(),
                          ),
                          _buildFacultyCard(
                            context,
                            'ښوونه او روزنه',
                            'د ښوونکو لپاره د مسلکي زده کړو پروګرامونه وړاندې کوي.',
                            'images/kdr_logo.png',
                            3,
                            20,
                            'images/kdr.jpg',
                            EducationScreen(),
                          ),
                          _buildFacultyCard(
                            context,
                            'اقتصاد',
                            'د اقتصاد په برخه کې زده کړې وړاندې کوي.',
                            'images/kdr_logo.png',
                            3,
                            20,
                            'images/kdr.jpg',
                            EconomicsScreen(),
                          ),
                          // Add more faculties similarly...
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacultyCard(
    BuildContext context,
    String title,
    String description,
    String iconImagePath, // ✅ Replaced IconData with String
    int departments,
    int staff,
    String backgroundImage,
    Widget facultyPage,
  ) {
    return SizedBox(
      width: 300,
      height: 400,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                backgroundImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        iconImagePath,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              departments.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'څانګې',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              staff.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'کارمندان',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => facultyPage,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تفصیل وګورئ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward,
                              color: Colors.black, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
