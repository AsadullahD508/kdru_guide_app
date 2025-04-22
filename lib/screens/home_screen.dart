import 'package:flutter/material.dart';
import '../widgets/custom_header.dart';
import '../widgets/custome_footer.dart';
import 'riast/riyasat_qadari_screen.dart';
import 'Qadri_hospital/hospital_screen.dart';
import 'faculties/faculty.dart';
import 'faculties/facultycard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomHeader(title: 'Home', selectedIndex: 0),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeroSection(context, screenWidth),
                  _buildKandaharUniversityInfoSection(),
                  _buildFeaturesSection(context, screenWidth),
                  _buildWelcomeSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, double screenWidth) {
    bool isMobile = screenWidth < 600;
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.school, color: Colors.blue, size: 32),
              ),
            ],
          ),
          const SizedBox(height: 24),
          isMobile
              ? Column(
                  children: [
                    _buildHeroTextPart(),
                    const SizedBox(height: 24),
                    _buildHeroImage(screenWidth),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildHeroTextPart()),
                    const SizedBox(width: 48),
                    _buildHeroImage(screenWidth),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeroTextPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome to\nKandahar University',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Find information about faculties, departments, admission, events, and more at Kandahar University.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildKandaharUniversityInfoSection() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.blue[100]!],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // Right-to-left alignment
        children: [
          const Text(
            'د کندهار پوهنتون تاریخچه',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'کندهار پوهنتون (Kandahar University) چې د کندهار پوهنتون په نوم هم پېژندل کېږي، په ۱۹۹۰ کال کې د افغانستان د لوړو زده کړو وزارت تر سرپرستۍ لاندې تاسیس شو. دا پوهنتون د هېواد له پنځو مهمو پوهنتونو څخه یو شمېرل کېږي او په کندهار ښار کې موقعیت لري، چې د کندهار ولایت د سیاسي او کلتوري مرکز په توګه پېژندل کېږي.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              height: 1.5,
            ),
            textAlign: TextAlign.right, // Right-aligned text
          ),
          const SizedBox(height: 16),
          const Text(
            'د پوهنتون تاریخچه: کندهار پوهنتون په ۱۹۹۰ کال کې د کرنې پوهنځي سره پیل شو. وروسته په ۱۹۹۳ کال کې د طب، انجنیري، ښوونه او روزنه، شریعت، اقتصاد، ژورنالیزم او عامه اړیکو، حقوق او سیاسي علوم، عامه اداره او پالیسۍ، ژبې او ادبیاتو، کمپیوټر ساینس، ستوماتولوژي او فارمسي پوهنځي یو په بل پسې تاسیس شول. پوهنتون د هېواد په سختو امنیتي، سیاسي او اقتصادي شرایطو کې هم د ځوان نسل روزنې او فارغ التحصیل کولو ته ادامه ورکړې ده.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              height: 1.5,
            ),
            textAlign: TextAlign.right, // Right-aligned text
          ),
          const SizedBox(height: 16),
          const Text(
            'تاسیس کال: ۱۹۹۰',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              height: 1.5,
            ),
            textAlign: TextAlign.right, // Right-aligned text
          ),
          const SizedBox(height: 16),
          const Text(
            'د پوهنځیو شمېر: ۱۲',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              height: 1.5,
            ),
            textAlign: TextAlign.right, // Right-aligned text
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(double screenWidth) {
    double imageSize = screenWidth < 600 ? screenWidth * 0.8 : 400;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'images/kdr.jpg',
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context, double screenWidth) {
    bool isMobile = screenWidth < 800;
    return Container(
      padding: const EdgeInsets.all(32.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore KDU',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: [
                    _buildFeatureCard(
                      context,
                      'Faculties',
                      'images/kdr.jpg',
                      'See all faculties',
                      const FacultyCard(),
                      isAsset: true,
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      context,
                      'Riayasaat',
                      'images/kdr.jpg',
                      'More details',
                      RiyasatScreen(),
                      isAsset: true,
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      context,
                      'hospital',
                      'images/kdr.jpg',
                      'More details',
                      const HospitalScreen(),
                      isAsset: true,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFeatureCard(
                      context,
                      'Faculties',
                      'images/kdr.jpg',
                      'See all faculties',
                      const FacultyScreen(),
                      isAsset: true,
                    ),
                    _buildFeatureCard(
                      context,
                      'روغتون',
                      'images/kdr.jpg',
                      'More details',
                      const HospitalScreen(),
                      isAsset: true,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String imageUrl,
    String buttonText,
    Widget page, {
    bool isAsset = false,
  }) {
    return Container(
      width: 300,
      height: 400,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: isAsset
              ? AssetImage(imageUrl) as ImageProvider
              : NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.blue[100]!],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          const CustomFooter(),
        ],
      ),
    );
  }
}
