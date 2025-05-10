import 'package:flutter/material.dart';
import 'package:Kdru_Guide_app/header.dart';

// Department Screens (create these screens in your Eng_Departments folder)
import 'Eng_Departments/civil_engineering.dart';
import 'Eng_Departments/energyDepartment.dart';
import 'Eng_Departments/water_engineering.dart';

class EngineeringFaculty extends StatelessWidget {
  const EngineeringFaculty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        children: [
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'د انجنري پوهنځي ته ښه راغلاست',
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
                      const Text(
                        'د انجنري پوهنځی',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'pashto',
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
                          'د انجنري پوهنځی د هیواد د بیارغونې، پراختیا او تخنیکي ظرفیت لوړولو لپاره جوړ شوی.',
                          style: TextStyle(
                            fontFamily: 'pashto',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(child: _buildStatCard('دیپارتمینټونه', '5')),
                          const SizedBox(width: 12),
                          Expanded(child: _buildStatCard('استادان', '20')),
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
                        'د یوه مسلکي، تخنیکي او تحقیق پر بنسټ انجنري پوهنځی جوړول، ترڅو هېواد ته تکړه انجنیران وړاندې کړي.',
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
                      _buildDepartmentsSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
              'https://images.unsplash.com/photo-1593005510945-d133d21b67e4'),
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
                'د یوه مسلکي، تخنیکي او تحقیق پر بنسټ انجنري پوهنځی جوړول...',
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
              'د انجنري پوهنځی د تدریس، څیړنې، تخنیکي پرمختګ او نوي اختراعاتو لپاره ژمن دی.',
              style: TextStyle(
                  fontSize: 16, color: Colors.white70, fontFamily: 'pashto'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDepartmentsSection(BuildContext context) {
    final departments = [
      {
        'title': 'ساختماني',
        'description':
            'د ساختماني انجنیري، نقشه جوړونې، او ساختماني موادو تمرکز.',
        'teacherCount': '7 ښوونکي',
        'courseCount': '14 کورسونه',
        'screen': const CivilDepartmentScreen(),
      },
      {
        'title': 'برېښنا',
        'description': 'د برېښنا، انرژی تولید او برېښنایی سیستمونو تمرکز.',
        'teacherCount': '5 ښوونکي',
        'courseCount': '12 کورسونه',
        'screen': const EnergyDepartmentScreen(),
      },
      {
        'title': 'اوبه او چاپیریال',
        'description': 'د اوبو مدیریت، اوبو رسونې او چاپېریالي مسایلو تمرکز.',
        'teacherCount': '6 ښوونکي',
        'courseCount': '11 کورسونه',
        'screen': const WaterEnvironmentalDepartmentScreen(),
      },
      {
        'title': 'د اوبواو انرژی ځانګه',
        'description': 'د ودانیو ډیزاین، ساختماني هنر او فضا جوړونې تمرکز.',
        'teacherCount': '3 ښوونکي',
        'courseCount': '9 کورسونه',
        'screen': const EnergyDepartmentScreen(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'څانګې',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B66),
              fontFamily: 'pashto'),
        ),
        const SizedBox(height: 16),
        ...departments.map((dept) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => dept['screen'] as Widget),
                  );
                },
                child: _buildDepartmentCard(
                  context,
                  dept['title'] as String,
                  dept['description'] as String,
                  dept['teacherCount'] as String,
                  dept['courseCount'] as String,
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
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
                fontFamily: 'pashto'),
          ),
          const SizedBox(height: 8),
          Text(description,
              style: TextStyle(
                  fontSize: 14, color: Colors.grey[600], fontFamily: 'pashto')),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.people, size: 16, color: Colors.black),
              const SizedBox(width: 8),
              Text(teacherCount,
                  style: const TextStyle(fontSize: 14, fontFamily: 'pashto')),
              const SizedBox(width: 24),
              const Icon(Icons.book, size: 16, color: Colors.black),
              const SizedBox(width: 8),
              Text(courseCount,
                  style: const TextStyle(fontSize: 14, fontFamily: 'pashto')),
            ],
          ),
        ],
      ),
    );
  }
}
