import 'package:flutter/material.dart';
import '../../widgets/custom_header.dart';

// Ensure to import all relevant faculty pages
import 'agriculture/agriculture_faculty_screen.dart';
import 'computer_science/faculty_screen.dart';
import 'economics/Economics_screen.dart';
import 'education/Education_screen.dart';
import 'engineeringFaculty/EngFaculty.dart';
import 'faculty_details_screen.dart';
import 'medicine/medicine_faculty_screen.dart';

class FacultyCard extends StatelessWidget {
  const FacultyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'پوهنځیو', selectedIndex: 1),
      body: Directionality(
        textDirection: TextDirection.rtl, // Apply RTL direction here
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
                            Icons.computer,
                            4,
                            28,
                            Scfaculty(), // Navigate to the Computer Science faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'انجنیرۍ',
                            'د انجنیري مختلفو برخو لکه ساختماني، برښنا، او اوبو او چاپېریال انجنیرۍ کې تخصص لري.',
                            Icons.engineering,
                            5,
                            32,
                            EngFaculty(), // Navigate to the Engineering faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'طب',
                            'د روغتیا په برخه کې زده کړې وړاندې کوي.',
                            Icons.local_hospital,
                            6,
                            45,
                            MedFaculty(), // Navigate to the Medicine faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'زراعت',
                            'د کرنې او زراعت په برخه کې زده کړې وړاندې کوي.',
                            Icons.agriculture,
                            3,
                            20,
                            AgrFaculty(), // Navigate to the Agriculture faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'ښوونه او روزنه',
                            'د ښوونکو لپاره د مسلکي زده کړو پروګرامونه وړاندې کوي.',
                            Icons.cast_for_education_rounded,
                            3,
                            20,
                            EducationScreen(), // Navigate to the Education faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'اقتصاد',
                            'د اقتصاد په برخه کې زده کړې وړاندې کوي.',
                            Icons.money,
                            3,
                            20,
                            EconomicsScreen(), // Navigate to the Economics faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'ژورنالیزم او عامه اړیکې',
                            'د رسنیو او عامه اړیکو په برخه کې زده کړې وړاندې کوي.',
                            Icons.article,
                            3,
                            20,
                            AgrFaculty(), // Navigate to the Journalism faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'ژبې او ادبیات',
                            'د مختلفو ژبو او ادبیاتو په برخه کې زده کړې وړاندې کوي.',
                            Icons.menu_book,
                            3,
                            20,
                            AgrFaculty(), // Navigate to the Languages and Literature faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'قانون او سیاسي علوم',
                            'د قانون او سیاسي علومو په برخه کې زده کړې وړاندې کوي.',
                            Icons.balance,
                            3,
                            20,
                            AgrFaculty(), // Navigate to the Law and Political Science faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'عامه اداره او پالیسۍ',
                            'د عامه ادارې او پالیسۍ په برخه کې زده کړې وړاندې کوي.',
                            Icons.people,
                            3,
                            20,
                            AgrFaculty(), // Navigate to the Public Administration and Policy faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'شریعت او قانون',
                            'د اسلامي قانون او شریعت په برخه کې زده کړې وړاندې کوي.',
                            Icons.mosque,
                            3,
                            20,
                            AgrFaculty(), // Navigate to the Sharia and Law faculty page
                          ),
                          _buildFacultyCard(
                            context,
                            'د عامې روغتیا ماسټرۍ',
                            'د عامې روغتیا په برخه کې ماسټرۍ وړاندې کوي.',
                            Icons.local_hospital,
                            3,
                            20,
                            AgrFaculty(), // Navigate to the Public Health Master program page
                          ),
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
    IconData icon,
    int departments,
    int staff,
    Widget facultyPage, // Pass the specific faculty page widget
  ) {
    return SizedBox(
      width: 300, // fixed width for each card
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right, // Set text alignment to right
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.right, // Set text alignment to right
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(departments.toString(), 'څانګې'),
                  _buildStatItem(staff.toString(), 'کارمندان'),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            facultyPage, // Use the passed faculty page widget
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('تفصیل وګورئ',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
