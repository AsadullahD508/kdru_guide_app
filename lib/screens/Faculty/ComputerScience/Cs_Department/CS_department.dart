import 'package:flutter/material.dart';
import '../Semesters/Cs_semesters.dart';
import '../Teachers/Cs_teachers.dart';
import 'package:Kdru_Guide_app/header.dart';

class ComputerScienceDepartment extends StatelessWidget {
  final String departmentName;

  const ComputerScienceDepartment({super.key, required this.departmentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.lightBlue[50], // Set background color to light blue
      body: Column(
        children: [
          // CustomHeader remains unaffected by RTL
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'کمپیوټر ساینس پوهنځي ته ښه راغلاست',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Directionality(
                  textDirection: TextDirection.rtl, // RTL for content only
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'د پوهنځي څانګه $departmentName',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D3B66),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'د کمپیوټر ساینس پوهنځی د ټیکنالوژۍ او نوښت یو مهم مرکز دی.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CsSemesters(),
                                  ),
                                );
                              },
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
                                  Text('سمیسټرونه'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ComputerScienceTeacherScreen(),
                                  ),
                                );
                              },
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
                                  Text('استادان'),
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
                            label: 'د پوهنځي استادان',
                            value: '۲۰',
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 16),
                          _StatCard(
                            icon: Icons.book_sharp,
                            label: 'کتابونه',
                            value: '۳۰',
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
                          color: Color(0xFF0D3B66),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildProgramCard(
                        'لیسانس',
                        'یوه څلور کلنه لېسانس دوره چې د کمپیوټر ساینس بنسټیز او پرمختللي مفاهیم پوښي.',
                        Icons.computer,
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                      color: Color(0xFF0D3B66),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
