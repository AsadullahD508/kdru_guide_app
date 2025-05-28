import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/buttom_header.dart';
import 'package:Kdru_Guide_app/header.dart';

class Homescreen extends StatefulWidget {
  final int selectedIndex;
  const Homescreen({super.key, this.selectedIndex = 2}); // default is 2

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late int _selectedIndex;

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

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F7FE),
      body: Column(
        children: [
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'د کند هار پوهنتون ته شه راغلاست',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildUniversityInfo(),
                  _buildFacultySection(),
                  _buildMapSection(),
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

  Widget _buildUniversityInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          Text(
            'د کندهار پوهنتون تاریخي شالید',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'pashto',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'کندهار پوهنتون د افغانستان په سویلي ولایت کندهار کې یو دولتي پوهنتون دی، چې په ۱۳۶۹ لمریز کال (۱۹۹۰ میلادي) د وخت د حکومت لخوا د کرنې پوهنځي په پرانیستلو سره تأسیس شو.'
            'کندهار پوهنتون د افغانستان په سویلي ولایت کندهار کې یو دولتي پوهنتون دی، چې په ۱۳۶۹ لمریز کال (۱۹۹۰ میلادي) د وخت د حکومت لخوا د کرنې پوهنځي په پرانیستلو سره تأسیس شو.'
            'کندهار پوهنتون د افغانستان په سویلي ولایت کندهار کې یو دولتي پوهنتون دی، چې په ۱۳۶۹ لمریز کال (۱۹۹۰ میلادي) د وخت د حکومت لخوا د کرنې پوهنځي په پرانیستلو سره تأسیس شو.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              fontFamily: 'pashto',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFacultySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Text(
            'پوهنځي',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'pashto',
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: faculties.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              return _buildFacultyCard(
                title: faculties[index]['name']!,
                imagePath: faculties[index]['image']!,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyCard({
    required String title,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(11.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'pashto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 200,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(31.6289, 65.7372),
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(31.6289, 65.7372),
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
