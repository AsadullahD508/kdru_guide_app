import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../../../header.dart';
import '../../../../widgets/buttom_header.dart';
import '../../../../language_provider.dart';
import '../Semesters/Cs_semesters.dart';
import '../Teachers/Cs_teachers.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return StreamBuilder<DocumentSnapshot>(
          stream: languageProvider
              .getDepartmentsCollectionRef(widget.facultyId)
              .doc(widget.departmentId)
              .snapshots(),
      builder: (context, departmentSnapshot) {
        if (departmentSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return Text(
                    languageProvider.getLocalizedString('departments_fetch_error'),
                    style: TextStyle(
                      fontFamily: languageProvider.getFontFamily(),
                    ),
                    textDirection: languageProvider.getTextDirection(),
                  );
                },
              ),
            ),
          );
        }

        if (departmentSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!departmentSnapshot.hasData || !departmentSnapshot.data!.exists) {
          return Scaffold(
            body: Center(
              child: Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return Text(
                    languageProvider.getLocalizedString('no_departments_found'),
                    style: TextStyle(
                      fontFamily: languageProvider.getFontFamily(),
                    ),
                    textDirection: languageProvider.getTextDirection(),
                  );
                },
              ),
            ),
          );
        }

        Map<String, dynamic> departmentData =
            departmentSnapshot.data!.data() as Map<String, dynamic>;

        return StreamBuilder<DocumentSnapshot>(
          stream: languageProvider
              .getFacultiesCollectionRef()
              .doc(widget.facultyId)
              .snapshots(),
          builder: (context, facultySnapshot) {
            if (facultySnapshot.hasError || !facultySnapshot.hasData) {
              return Scaffold(
                body: Center(
                  child: Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return Text(
                        languageProvider.getLocalizedString('faculties_fetch_error'),
                        style: TextStyle(
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      );
                    },
                  ),
                ),
              );
            }

            Map<String, dynamic> facultyData =
                facultySnapshot.data!.data() as Map<String, dynamic>;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                bottomNavigationBar: CustomBottomNavBar(
                  onItemTapped: _onItemTapped,
                  selectedIndex: 1,
                ),
                backgroundColor: Colors.lightBlue[50],
                body: Column(
                  children: [
                    Consumer<LanguageProvider>(
                      builder: (context, languageProvider, child) {
                        return CustomHeader(
                          userName: languageProvider.getLocalizedString('guest_user'),
                          bannerImagePath: facultyData['logo'] ??
                              'images/kdr_logo.png',
                          fullText: '${departmentData['name']} ${languageProvider.getLocalizedString('department_name')}',
                        );
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Consumer<LanguageProvider>(
                              builder: (context, languageProvider, child) {
                                return _buildInfoCard(
                                  languageProvider.getLocalizedString('information'),
                                  departmentData['description'] ?? '',
                                  languageProvider,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Consumer<LanguageProvider>(
                                    builder: (context, languageProvider, child) {
                                      return _buildNavigationCard(
                                        context,
                                        languageProvider.getLocalizedString('teachers'),
                                        Icons.people,
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AllTeachersScreen(
                                              facultyData: {
                                                'id': widget.facultyId,
                                                'name': facultyData['name'],
                                                'logo': facultyData['logo'],
                                              },
                                              departmentData: {
                                                'id': widget.departmentId,
                                                'name': departmentData['name'],
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Consumer<LanguageProvider>(
                                    builder: (context, languageProvider, child) {
                                      return _buildNavigationCard(
                                        context,
                                        languageProvider.getLocalizedString('semesters'),
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
                                      );
                                    },
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
              ),
            );
          },
        );
      },
        );
      },
    );
  }

  Widget _buildInfoCard(String title, String content, LanguageProvider languageProvider) {
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
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: languageProvider.getFontFamily(),
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              fontFamily: languageProvider.getFontFamily(),
            ),
            textAlign: languageProvider.getTextDirection() == TextDirection.rtl
                ? TextAlign.right
                : TextAlign.left,
            textDirection: languageProvider.getTextDirection(),
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
