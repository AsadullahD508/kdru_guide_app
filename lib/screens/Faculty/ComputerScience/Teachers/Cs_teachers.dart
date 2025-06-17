import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../../header.dart';
import '../../../../widgets/buttom_header.dart';
import '../../../../language_provider.dart';
import 'TeacherProfileScreen.dart';

class AllTeachersScreen extends StatefulWidget {
  final Map<String, dynamic> facultyData;
  final Map<String, dynamic> departmentData;

  const AllTeachersScreen({
    super.key,
    required this.facultyData,
    required this.departmentData,
  });

  @override
  State<AllTeachersScreen> createState() => _AllTeachersScreenState();
}

class _AllTeachersScreenState extends State<AllTeachersScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String facultyId = widget.facultyData['id'] ?? '';
    final String departmentId = widget.departmentData['id'] ?? '';

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Directionality(
          textDirection: languageProvider.getTextDirection(),
          child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: Column(
          children: [
            Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
                return CustomHeader(
                  userName: languageProvider.getLocalizedString('guest_user'),
                  bannerImagePath:
                      widget.facultyData['logo'] ?? 'images/kdr_logo.png',
                  fullText:
                      '${widget.facultyData['name'] ?? languageProvider.getLocalizedString('faculties')} - ${widget.departmentData['name'] ?? languageProvider.getLocalizedString('department')}',
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: languageProvider
                        .getTeachersCollectionRef(facultyId, departmentId)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Consumer<LanguageProvider>(
                        builder: (context, langProvider, child) {
                          return Text(
                            langProvider.getLocalizedString('teachers_fetch_error'),
                            style: TextStyle(fontFamily: langProvider.getFontFamily()),
                            textDirection: langProvider.getTextDirection(),
                          );
                        },
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final teachers = snapshot.data!.docs;

                  if (teachers.isEmpty) {
                    return Center(
                      child: Consumer<LanguageProvider>(
                        builder: (context, langProvider, child) {
                          return Text(
                            langProvider.getLocalizedString('no_teachers_found_error'),
                            style: TextStyle(fontFamily: langProvider.getFontFamily()),
                            textDirection: langProvider.getTextDirection(),
                          );
                        },
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: teachers.length,
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      final teacherData =
                          teachers[index].data() as Map<String, dynamic>;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherProfileScreen(
                                teacherId: teachers[index].id,
                                facultyId: facultyId,
                                departmentId: departmentId,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage:
                                      teacherData['avatarUrl'] != null
                                          ? CachedNetworkImageProvider(
                                              teacherData['avatarUrl'],
                                            )
                                          : null,
                                  child: teacherData['avatarUrl'] == null
                                      ? const Icon(Icons.person,
                                          color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        teacherData['fullName'] ?? 'نامعلوم',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'pashto',
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'ټیلفون: ${teacherData['phone'] ?? '؟'} ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                          fontFamily: 'pashto',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'ایمیل: ${teacherData['email'] ?? '؟'} ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontFamily: 'pashto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: _onItemTapped,
          selectedIndex: 1,
        ),
      ),
        );
      },
    );
  }
}
