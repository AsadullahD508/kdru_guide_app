import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/buttom_header.dart';
import 'package:Kdru_Guide_app/header.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> faculties = [
    {'name': 'د کمپیوټر ساینس پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د انجینرۍ پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د اقتصاد پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د حقوقو او سیاسي علومو پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د کرنې پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د تعلیم او تربیې پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د شرعیاتو پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د ژورنالیزم پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د ادبیاتو پوهنځي', 'image': 'images/hospital.png'},
    {'name': 'د وترنري پوهنځي', 'image': 'images/learning.jpg'},
    {'name': 'د طب پوهنځي', 'image': 'images/learning.jpg'},
    {'name': 'د عامې روغتیا پوهنځي', 'image': 'images/hospital.png'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/hospital.png',
            fullText: 'د کند هار پوهنتون معلومات',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeroSection(screenWidth),
                  _buildKandaharUniversityInfoSection(),
                  _buildMapSection(),
                  _buildWelcomeSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildHeroSection(double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                'images/kdr_logo.png',
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildKandaharUniversityInfoSection() {
    return Container(
      color: Colors.white, // Set the background color to white
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'د کندهار پوهنتون تاریخي شالید',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors
                  .black, // Changed text color to black for better contrast
              fontFamily: 'pashto',
            ),
          ),
          const SizedBox(height: 12),
          const SizedBox(height: 16),
          const Text(
            'کندهار پوهنتون د افغانستان په سویلي ولایت کندهار کې یو دولتي پوهنتون دی، چې په ۱۳۶۹ لمریز کال (۱۹۹۰ میلادي) د وخت د حکومت لخوا د کرنې پوهنځي په پرانیستلو سره تأسیس شو. '
            'کندهار پوهنتون د افغانستان په سویلي ولایت کندهار کې یو دولتي پوهنتون دی، چې په ۱۳۶۹ لمریز کال (۱۹۹0 میلادي) د وخت د حکومت لخوا د کرنې پوهنځي په پرانیستلو سره تأسیس شو. '
            'کندهار پوهنتون د افغانستان په سویلي ولایت کندهار کې یو دولتي پوهنتون دی، چې په ۱۳۶۹ لمریز کال (۱۹۹0 میلادي) د وخت د حکومت لخوا د کرنې پوهنځي په پرانیستلو سره تأسیس شو.',
            style: TextStyle(
              fontSize: 18,
              color: Colors
                  .black, // Changed text color to black for better contrast
              height: 1.6,
              fontFamily: 'pashto',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Faculty count
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  'images/hostel (1).png',
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '۱۲ پوهنځي',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .black, // Changed text color to black for better contrast
                  fontFamily: 'pashto',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Faculty section (Displayed in a column, one by one)
          const Text(
            'پوهنځي',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors
                  .black, // Changed text color to black for better contrast
              fontFamily: 'pashto',
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: faculties.map((faculty) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset(
                      faculty['image']!,
                      height: 40, // Made the image smaller
                      width: 40, // Made the image smaller
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    faculty['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors
                          .black, // Changed text color to black for better contrast
                      fontFamily: 'pashto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16), // Add space between items
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueGrey.shade100),
      ),
      clipBehavior: Clip.antiAlias,
      child: FlutterMap(
        options: const MapOptions(
          center: LatLng(31.6107, 65.6910),
          zoom: 15.0,
          interactiveFlags: InteractiveFlag.doubleTapZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          const MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(31.6107, 65.6910),
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
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
      child: const Text(
        'ښه راغلاست زموږ اپلیکیشن ته! تاسو کولی شئ د پوهنتون په اړه معلومات، نقشې، پوهنځي او نور وګورئ.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'pashto',
        ),
      ),
    );
  }
}
