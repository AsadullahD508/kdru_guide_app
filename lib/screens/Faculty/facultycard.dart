import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '../../widgets/buttom_header.dart';
import '../../header.dart';
import '../../language_provider.dart';
import 'ComputerScience/CS_home.dart';
import '../../home.dart';

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
      iconUrl: data['logo'] ?? '',
      departments: data['departments'] ?? 0,
      staff: data['staff'] ?? 0,
      backgroundUrl: data['logo'] ?? '', // Use logo for both icon and background
      type: data['type'] ?? '',
    );
  }
}

class FacultyCard extends StatefulWidget {
  const FacultyCard({super.key});

  @override
  _FacultyCardScreenState createState() => _FacultyCardScreenState();
}

class _FacultyCardScreenState extends State<FacultyCard>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late AnimationController _controller;
  late Animation<double> _hoverAnimation;
  String _currentLanguage = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageProvider = Provider.of<LanguageProvider>(context);
    if (languageProvider.isInitialized && _currentLanguage != languageProvider.currentLanguage) {
      _currentLanguage = languageProvider.currentLanguage;
      // Trigger rebuild when language changes
      setState(() {});
    }
  }

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
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      QuerySnapshot snapshot = await languageProvider
          .getDepartmentsCollectionRef(facultyId)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> _getTeacherCount(String facultyId) async {
    try {
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      // Try both 'teachers' and 'teacher' collections for compatibility
      try {
        QuerySnapshot snapshot = await languageProvider
            .getFacultiesCollectionRef()
            .doc(facultyId)
            .collection('teachers')
            .get();
        return snapshot.docs.length;
      } catch (e) {
        // Try alternative collection name
        QuerySnapshot snapshot = await languageProvider
            .getFacultiesCollectionRef()
            .doc(facultyId)
            .collection('teacher')
            .get();
        return snapshot.docs.length;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<Map<String, int>> _getCombinedCounts(String facultyId) async {
    try {
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

      // Get departments count
      final departmentsSnapshot = await languageProvider.getDepartmentsCollectionRef(facultyId).get();
      final departmentsCount = departmentsSnapshot.docs.length;

      // Count teachers from multiple sources
      int totalTeachers = 0;

      // 1. First, try to get teachers directly from faculty level (like in CS_home.dart)
      try {
        final facultyTeachersSnapshot = await languageProvider
            .getFacultiesCollectionRef()
            .doc(facultyId)
            .collection('teachers')
            .get();
        totalTeachers += facultyTeachersSnapshot.docs.length;
        debugPrint('Found ${facultyTeachersSnapshot.docs.length} teachers at faculty level for $facultyId');
      } catch (e) {
        debugPrint('No teachers found at faculty level for $facultyId: $e');
      }

      // 2. Also try alternative faculty-level collection name
      try {
        final facultyTeacherSnapshot = await languageProvider
            .getFacultiesCollectionRef()
            .doc(facultyId)
            .collection('teacher')
            .get();
        totalTeachers += facultyTeacherSnapshot.docs.length;
        debugPrint('Found ${facultyTeacherSnapshot.docs.length} teachers in "teacher" collection at faculty level for $facultyId');
      } catch (e) {
        debugPrint('No "teacher" collection found at faculty level for $facultyId: $e');
      }

      // 3. Count teachers across all departments (in case some are stored there)
      for (var departmentDoc in departmentsSnapshot.docs) {
        try {
          // Try 'teachers' collection first
          final teachersSnapshot = await languageProvider
              .getTeachersCollectionRef(facultyId, departmentDoc.id)
              .get();
          totalTeachers += teachersSnapshot.docs.length;
          debugPrint('Found ${teachersSnapshot.docs.length} teachers in department ${departmentDoc.id}');
        } catch (e) {
          // If 'teachers' collection doesn't exist, try 'teacher' collection for compatibility
          try {
            final teacherSnapshot = await languageProvider
                .getDepartmentsCollectionRef(facultyId)
                .doc(departmentDoc.id)
                .collection('teacher')
                .get();
            totalTeachers += teacherSnapshot.docs.length;
            debugPrint('Found ${teacherSnapshot.docs.length} teachers in "teacher" collection for department ${departmentDoc.id}');
          } catch (e2) {
            // If neither collection exists, continue to next department
            debugPrint('No teachers found in department ${departmentDoc.id}: $e2');
          }
        }
      }

      debugPrint('Total teachers found for faculty $facultyId: $totalTeachers');
      return {
        'departments': departmentsCount,
        'teachers': totalTeachers,
      };
    } catch (e) {
      debugPrint('Error getting combined counts: $e');
      return {'departments': 0, 'teachers': 0};
    }
  }

  Widget _countInfoItem(String title, int count, LanguageProvider languageProvider) {
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
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
            fontFamily: languageProvider.getFontFamily(),
          ),
          textDirection: languageProvider.getTextDirection(),
        ),
      ],
    );
  }

  Widget _buildFacultyCard(BuildContext context, Faculty faculty, LanguageProvider languageProvider) {
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
              child: Hero(
                tag: 'faculty_bg_${faculty.id}_${faculty.backgroundUrl.hashCode}',
                child: CachedNetworkImage(
                  imageUrl: faculty.backgroundUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(
                    child:
                        Icon(Icons.broken_image, size: 60, color: Colors.white),
                  ),
                ),
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
                      child: Hero(
                        tag: 'faculty_icon_${faculty.id}_${(faculty.iconUrl ?? '').hashCode}',
                        child: CachedNetworkImage(
                          imageUrl: faculty.iconUrl ?? '',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            width: 32,
                            height: 32,
                            child: Icon(Icons.broken_image,
                                size: 24, color: Colors.grey),
                          ),
                        ),
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
                  FutureBuilder<Map<String, int>>(
                    future: _getCombinedCounts(faculty.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      final data = snapshot.data!;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _countInfoItem('څانګې', data['departments']!, languageProvider),
                          _countInfoItem('استادان', data['teachers']!, languageProvider),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        onEnter: (_) => _controller.forward(),
                        onExit: (_) => _controller.reverse(),
                        child: ScaleTransition(
                          scale: _hoverAnimation,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.8),
                              foregroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              _controller.forward(from: 0.0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacultyScreen(
                                    facultyId: faculty.id,
                                    galleryId: 'galleryId',
                                    departmentId: 'departmentId',
                                  ),
                                ),
                              );
                            },
                            icon: Image.asset(
                              'images/seo.png',
                              width: 24,
                              height: 24,
                            ),
                            label: Text(
                              languageProvider.getLocalizedString('for_more_info'),
                              style: TextStyle(
                                fontFamily: languageProvider.getFontFamily(),
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
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // Navigate back to Home screen when hardware back button is pressed
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const FirstHomescreen()),
      (Route<dynamic> route) => false,
    );
    return false; // Prevent default back behavior
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        if (!languageProvider.isInitialized || languageProvider.isLoading) {
          return Scaffold(
            backgroundColor: const Color(0xFFE5F7FE),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return Text(
                        languageProvider.getLocalizedString('loading'),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
            body: Container(
              color: Colors.lightBlue[50],
              child: Column(
                children: [
                  FutureBuilder<String>(
                    future: _getImageUrl('images/kdr_logo.png'),
                    builder: (context, snapshot) {
                      return const CustomHeader(
                        userName: 'Guest User',
                        bannerImagePath: 'images/department (2).png',
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
                            Text(
                              languageProvider.getLocalizedString('faculties'),
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0D3B66),
                                fontFamily: languageProvider.getFontFamily(),
                              ),
                              textDirection: languageProvider.getTextDirection(),
                            ),
                            const SizedBox(height: 24),
                            StreamBuilder<QuerySnapshot>(
                              stream: languageProvider
                                  .getFacultiesCollectionRef()
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  languageProvider.getLocalizedString('error_occurred'),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: languageProvider.getFontFamily(),
                                  ),
                                  textDirection: languageProvider.getTextDirection(),
                                ),
                              );
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  languageProvider.getLocalizedString('no_faculty_found'),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                    fontFamily: languageProvider.getFontFamily(),
                                  ),
                                  textDirection: languageProvider.getTextDirection(),
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
                                      _buildFacultyCard(context, faculty, languageProvider))
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
      },
    ),
    );
  }
}
