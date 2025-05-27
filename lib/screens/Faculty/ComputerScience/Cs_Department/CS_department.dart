import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../header.dart';
import '../../../../widgets/buttom_header.dart';
import '../Semesters/Cs_semesters.dart';
import '../Teachers/Cs_teachers.dart';

// ستاسو د CustomBottomNavBar فایل ایمپورټ
// دلته د خپلې فایل لاره ولیکئ

class DepartmentScreen extends StatefulWidget {
  final String facultyId;
  final String departmentId;

  DepartmentScreen({
    Key? key,
    required this.facultyId,
    required this.departmentId,
  }) : super(key: key);

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // دلته د نیویګیشن یا کوم بل کار ترسره کړئ
    // مثلا:
    if (index == 0) {
      // کوم صفحه ته لاړ شئ
    } else if (index == 1) {
      // اوسنی صفحه
    } else if (index == 2) {
      // بله صفحه
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('Kandahar University')
          .doc('kdru')
          .collection('faculties')
          .doc(widget.facultyId)
          .collection('departments')
          .doc(widget.departmentId)
          .snapshots(),
      builder: (context, departmentSnapshot) {
        if (departmentSnapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('د څانګې معلوماتو کې ستونزه پیدا شوه')),
          );
        }

        if (departmentSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!departmentSnapshot.hasData || !departmentSnapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text('څانګه ونه موندل شوه')),
          );
        }

        Map<String, dynamic> departmentData =
            departmentSnapshot.data!.data() as Map<String, dynamic>;

        return StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection('Kandahar University')
              .doc('kdru')
              .collection('faculties')
              .doc(widget.facultyId)
              .snapshots(),
          builder: (context, facultySnapshot) {
            if (facultySnapshot.hasError || !facultySnapshot.hasData) {
              return const Scaffold(
                body:
                    Center(child: Text('د پوهنځي معلوماتو کې ستونزه پیدا شوه')),
              );
            }

            Map<String, dynamic> facultyData =
                facultySnapshot.data!.data() as Map<String, dynamic>;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Colors.lightBlue[50],
                body: Column(
                  children: [
                    CustomHeader(
                      userName: 'Guest User',
                      bannerImagePath: facultyData['backgroundUrl'] ??
                          'images/department (2).png',
                      fullText: '${departmentData['name']} څانګه',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildInfoCard(
                              'معلومات',
                              departmentData['description'] ?? '',
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildNavigationCard(
                                    context,
                                    'استادان',
                                    Icons.people,
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllTeachersScreen(
                                          facultyData: {
                                            'id': widget.facultyId,
                                            'name': facultyData['name'],
                                            'backgroundUrl':
                                                facultyData['backgroundUrl'],
                                          },
                                          departmentData: {
                                            'id': widget.departmentId,
                                            'name': departmentData['name'],
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildNavigationCard(
                                    context,
                                    'سمسټرونه',
                                    Icons.calendar_today,
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CurriculumScreen(
                                          facultyId: widget.facultyId,
                                          departmentId: widget.departmentId,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: CustomBottomNavBar(
                  onItemTapped: _onItemTapped,
                  selectedIndex: _selectedIndex,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'pashto',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              fontFamily: 'pashto',
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'pashto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
