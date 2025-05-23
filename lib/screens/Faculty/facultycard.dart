import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../widgets/buttom_header.dart';
import '../../header.dart';
import 'ComputerScience/CS_home.dart';

class Faculty {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final int departments;
  final int staff;
  final String backgroundUrl;
  final String type;

  Faculty({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.departments,
    required this.staff,
    required this.backgroundUrl,
    required this.type,
  });

  factory Faculty.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Faculty(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      iconUrl: data['iconUrl'] ?? '',
      departments: data['departments'] ?? 0,
      staff: data['staff'] ?? 0,
      backgroundUrl: data['logo'] ?? '',
      type: data['type'] ?? '',
    );
  }
}

class FacultyCard extends StatefulWidget {
  const FacultyCard({super.key});

  @override
  _FacultyCardScreenState createState() => _FacultyCardScreenState();
}

class _FacultyCardScreenState extends State<FacultyCard> {
  int _selectedIndex = 1;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<String> _getImageUrl(String path) async {
    try {
      return await _storage.ref(path).getDownloadURL();
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

  Future<int> _getDepartmentCount(String facultyId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Kandahar University')
          .doc('kdru')
          .collection('faculties')
          .doc(facultyId)
          .collection('departments')
          .get();
      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> _getTeacherCount(String facultyId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Kandahar University')
          .doc('kdru')
          .collection('faculties')
          .doc(facultyId)
          .collection('teacher')
          .get();
      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  Widget _countInfoItem(String title, int count) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildFacultyCard(BuildContext context, Faculty faculty) {
    return SizedBox(
      width: 300,
      height: 460,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: faculty.backgroundUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FutureBuilder<String>(
                        future: _getImageUrl(faculty.iconUrl),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CachedNetworkImage(
                            imageUrl: snapshot.data!,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AutoSizeText(
                    faculty.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  AutoSizeText(
                    faculty.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  FutureBuilder<int>(
                    future: _getDepartmentCount(faculty.id),
                    builder: (context, deptSnapshot) {
                      if (!deptSnapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return FutureBuilder<int>(
                        future: _getTeacherCount(faculty.id),
                        builder: (context, teacherSnapshot) {
                          if (!teacherSnapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _countInfoItem('څانګې', deptSnapshot.data!),
                              _countInfoItem('استادان', teacherSnapshot.data!),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          foregroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FacultyScreen(
                                  facultyId: faculty.id, section: "teachers"),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person),
                        label: const Text('د نورو معلوماتو لپاره'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[50],
        child: Column(
          children: [
            FutureBuilder<String>(
              future: _getImageUrl('images/kdr_logo.png'),
              builder: (context, snapshot) {
                return CustomHeader(
                  userName: 'Guest User',
                  bannerImagePath: snapshot.data ?? 'images/kdr_logo.png',
                  fullText: 'د کند هار پوهنتون پوهنځي',
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'پوهنځۍ',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D3B66),
                          ),
                        ),
                        const SizedBox(height: 24),
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Kandahar University')
                              .doc('kdru')
                              .collection('faculties')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  'خطا پېښه شوه. بیا هڅه وکړئ.',
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text(
                                  'هیڅ پوهنځی ونه موندل شو.',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                              );
                            }

                            List<Faculty> faculties = snapshot.data!.docs
                                .map((doc) => Faculty.fromFirestore(doc))
                                .toList();

                            return Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              children: faculties
                                  .map((faculty) =>
                                      _buildFacultyCard(context, faculty))
                                  .toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
