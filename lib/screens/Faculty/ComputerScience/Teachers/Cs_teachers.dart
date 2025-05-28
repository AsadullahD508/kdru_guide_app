import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../header.dart';
import '../../../../widgets/buttom_header.dart';
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: Column(
          children: [
            CustomHeader(
              userName: 'Guest User',
              bannerImagePath:
                  widget.facultyData['avatarUrl'] ?? 'images/kdr_logo.png',
              fullText:
                  '${widget.facultyData['name'] ?? 'پوهنځی'} - ${widget.departmentData['name'] ?? 'څانګه'}',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Kandahar University')
                    .doc('kdru')
                    .collection('faculties')
                    .doc(facultyId)
                    .collection('departments')
                    .doc(departmentId)
                    .collection('teachers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'د استادانو په ترلاسه کولو کې ستونزه رامنځته شوه.',
                        style: TextStyle(fontFamily: 'pashto'),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final teachers = snapshot.data!.docs;

                  if (teachers.isEmpty) {
                    return const Center(
                      child: Text(
                        'هیڅ استاد ونه موندل شو.',
                        style: TextStyle(fontFamily: 'pashto'),
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
  }
}
