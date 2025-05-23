import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../header.dart';

import '../Semesters/Cs_semesters.dart';
import '../Teachers/Cs_teachers.dart';

class DepartmentScreen extends StatelessWidget {
  final String facultyId;
  final String departmentId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DepartmentScreen({
    Key? key,
    required this.facultyId,
    required this.departmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('Kandahar University')
          .doc('kdru')
          .collection('faculties')
          .doc(facultyId)
          .collection('departments')
          .doc(departmentId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading department data')),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text('Department not found')),
          );
        }

        Map<String, dynamic> departmentData =
            snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          backgroundColor: Colors.lightBlue[50],
          body: Column(
            children: [
              CustomHeader(
                userName: 'Guest User',
                bannerImagePath: departmentData['backgroundUrl'] ?? '',
                fullText: departmentData['name'] ?? '',
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
                                  builder: (context) => TeachersScreen(
                                    facultyId: facultyId,
                                    departmentId: departmentId,
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
                                  builder: (context) => SemesterScreen(
                                    facultyId: facultyId,
                                    departmentId: departmentId,
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
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
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
