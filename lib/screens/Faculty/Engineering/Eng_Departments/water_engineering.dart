import 'package:flutter/material.dart';
import 'package:Kdru_Guide_app/header.dart';
import '../../../../widgets/buttom_header.dart';

class WaterEnvironmentalDepartmentScreen extends StatelessWidget {
  const WaterEnvironmentalDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onItemTapped: (index) {},
      ),
      body: Column(
        children: [
          // 🔵 Header stays in LTR
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'د اوبو او چاپېریالي انجینرۍ پوهنځي ته ښه راغلاست',
          ),
          // 🔵 Rest of the content is in RTL
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'د اوبو او چاپېریالي انجینرۍ څانګه',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PashtoFont',
                          color: Color(0xFF0D3B66),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'د اوبو او چاپېریالي انجینرۍ پوهنځی د اوبو سرچینو، سپلاي، اوبو لګولو، فاضله اوبو، او د چاپېریال ککړتیا په برخه کې تخصص لري.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'PashtoFont',
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo[100],
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'سمیسټرونه',
                                    style: TextStyle(fontFamily: 'PashtoFont'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo[100],
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.people, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'استادان',
                                    style: TextStyle(fontFamily: 'PashtoFont'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Row(
                        children: [
                          _StatCard(
                            icon: Icons.people,
                            label: 'د اوبو او چاپېریالي انجینرۍ استادان',
                            value: '۱۲',
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 16),
                          _StatCard(
                            icon: Icons.book_sharp,
                            label: 'کتابونه',
                            value: '۱۵',
                            color: Colors.brown,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'پېشنهاد شوي پروګرامونه',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PashtoFont',
                          color: Color(0xFF0D3B66),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildProgramCard(
                        'لیسانس',
                        'یوه څلور کلنه لېسانس دوره چې د اوبو او چاپېریالي انجینرۍ بنسټیز او پرمختللي مفاهیم پوښي.',
                        Icons.water_damage,
                      ),
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

  static Widget _buildProgramCard(
      String title, String description, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: const Color(0xFF0D3B66)),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PashtoFont',
                      color: Color(0xFF0D3B66),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'PashtoFont',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PashtoFont',
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'PashtoFont',
                  color: color.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
