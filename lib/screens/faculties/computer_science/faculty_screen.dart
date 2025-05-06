import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';
import 'department_screen.dart' show ComputerScienceDepartment;
import 'department_screen.dart';

class CsFaculty extends StatelessWidget {
  const CsFaculty({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CustomHeader(
          title: 'کمپیوټر ساینس پوهنځي',
          selectedIndex: 1,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'کمپیوټر ساینس پوهنځي',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PashtoFont',
                          color: Color(0xFF0D3B66),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'د کمپيوټر ساينس پوهنځی د۱۳۹۳ یا ۲۰۱۴ کال کي تاسيس سوه...',
                          style: TextStyle(
                            fontFamily: 'PashtoFont',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Insert President Profile here
                      const PresidentProfileCard(
                        name: 'پوهنیار نیاز محمد دوستیار',
                        title: 'رئيس، کمپیوټر ساینس پوهنځی',
                        email: 'ahmadi@gmail.com',
                        phone: '93701234567+',
                        specialization: 'تخصص: د معلوماتي سیسټمونو پراختیا',
                        research:
                            'ریسرچ: د معلوماتي سیسټمونو مدغم کول، د مصنوعي ځیرکتیا ټکنالوجي',
                        degree: ' درجه: PHDد کمپیوټر ساینس',
                      ),
                      const SizedBox(height: 32),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatCard('ښوونکي', '10'),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return constraints.maxWidth < 800
                              ? Column(
                                  children: [
                                    _buildDepartmentsSection(context),
                                    const SizedBox(height: 40),
                                  ],
                                )
                              : const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [],
                                );
                        },
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B66),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDepartmentsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'څانګي',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: _buildDepartmentCard(
            context,
            'عمومي',
            'د سافټویر پراختیا، ډیزاین او ازمایښت تمرکز.',
            '5 ښوونکي',
            '12 کورسونه',
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  static Widget _buildDepartmentCard(
    BuildContext context,
    String title,
    String description,
    String teacherCount,
    String courseCount,
  ) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B66),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.people, size: 16, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  teacherCount,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 24),
                Icon(Icons.book, size: 16, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  courseCount,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ComputerScienceDepartment(departmentName: title),
                ),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('د ډپارټمنټ لیدنه'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PresidentProfileCard extends StatelessWidget {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String specialization;
  final String research;
  final String degree;

  const PresidentProfileCard({
    super.key,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.research,
    required this.degree,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'images/hoodman.jpg', // Ensure to use the correct image
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.email, email),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.phone, phone),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.school, specialization),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.book, research),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.school, degree),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.blue[700],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
