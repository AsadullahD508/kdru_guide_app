import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../header.dart';
import '../../../widgets/buttom_header.dart';
import '../../../language_provider.dart';

import 'Cs_Department/CS_department.dart';
import 'Teachers/Cs_teachers.dart';
import '../../../utils/responsive_utils.dart';
import '../all_faculty_teachers.dart';

class FacultyScreen extends StatefulWidget {
  final String facultyId;
  final String galleryId;
  final String departmentId;

  const FacultyScreen(
      {Key? key,
      required this.facultyId,
      required this.galleryId,
      required this.departmentId})
      : super(key: key);

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<Map<String, int>> _getStats() async {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    // Get departments count
    final departmentsSnapshot = await languageProvider
        .getDepartmentsCollectionRef(widget.facultyId)
        .get();
    final departmentsCount = departmentsSnapshot.size;

    // Count ALL teachers from multiple sources (same logic as faculty card)
    int totalTeachers = 0;

    // 1. First, try to get teachers directly from faculty level
    try {
      final facultyTeachersSnapshot = await languageProvider
          .getFacultiesCollectionRef()
          .doc(widget.facultyId)
          .collection('teachers')
          .get();
      totalTeachers += facultyTeachersSnapshot.docs.length;
      debugPrint(
          'Found ${facultyTeachersSnapshot.docs.length} teachers at faculty level for ${widget.facultyId}');
    } catch (e) {
      debugPrint(
          'No teachers found at faculty level for ${widget.facultyId}: $e');
    }

    // 2. Also try alternative faculty-level collection name
    try {
      final facultyTeacherSnapshot = await languageProvider
          .getFacultiesCollectionRef()
          .doc(widget.facultyId)
          .collection('teacher')
          .get();
      totalTeachers += facultyTeacherSnapshot.docs.length;
      debugPrint(
          'Found ${facultyTeacherSnapshot.docs.length} teachers in "teacher" collection at faculty level for ${widget.facultyId}');
    } catch (e) {
      debugPrint(
          'No "teacher" collection found at faculty level for ${widget.facultyId}: $e');
    }

    for (var departmentDoc in departmentsSnapshot.docs) {
      try {
        final teachersSnapshot = await languageProvider
            .getTeachersCollectionRef(widget.facultyId, departmentDoc.id)
            .get();
        totalTeachers += teachersSnapshot.docs.length;
        debugPrint(
            'Found ${teachersSnapshot.docs.length} teachers in department ${departmentDoc.id}');
      } catch (e) {
        // If 'teachers' collection doesn't exist, try 'teacher' collection for compatibility
        try {
          final teacherSnapshot = await languageProvider
              .getDepartmentsCollectionRef(widget.facultyId)
              .doc(departmentDoc.id)
              .collection('teacher')
              .get();
          totalTeachers += teacherSnapshot.docs.length;
          debugPrint(
              'Found ${teacherSnapshot.docs.length} teachers in "teacher" collection for department ${departmentDoc.id}');
        } catch (e2) {
          // If neither collection exists, continue to next department
          debugPrint(
              'No teachers found in department ${departmentDoc.id}: $e2');
        }
      }
    }

    debugPrint(
        'Total teachers found for faculty ${widget.facultyId}: $totalTeachers');

    return {
      'departmentsCount': departmentsCount,
      'staffCount': totalTeachers,
      'labCount': totalTeachers, // Using same count for lab count
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: 1,
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return StreamBuilder<DocumentSnapshot>(
            stream: languageProvider
                .getFacultiesCollectionRef()
                .doc(widget.facultyId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                    child: Text('د معلوماتو په لوستلو کې تېروتنه وشوه',
                        style: TextStyle(fontFamily: 'pashto')));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(
                    child: Text('پوهنځی ونه موندل شو',
                        style: TextStyle(fontFamily: 'pashto')));
              }

              Map<String, dynamic> facultyData =
                  snapshot.data!.data() as Map<String, dynamic>;

              return Directionality(
                textDirection: languageProvider.getTextDirection(),
                child: Scaffold(
                  backgroundColor: Colors.lightBlue[50],
                  body: Column(
                    children: [
                      CustomHeader(
                        userName: 'Guest User',
                        bannerImagePath:
                            facultyData['logo'] ?? 'images/kdr_logo.png',
                        fullText: facultyData['name'] ?? 'پوهنځی',
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding:
                              ResponsiveUtils.getResponsivePadding(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl: facultyData['logo'] ?? '',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Icon(
                                          Icons.school,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Image.asset(
                                          'images/kdr_logo.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    facultyData['name'] ?? '',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'pashto',
                                        color: Color(0xFF0D3B66)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildSectionTitleWithIcon(
                                      languageProvider
                                          .getLocalizedString('history'),
                                      'images/hospital.png',
                                      languageProvider);
                                },
                              ),
                              const SizedBox(height: 12),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildInfoCard(
                                    facultyData['description'] ??
                                        languageProvider
                                            .getLocalizedString('history'),
                                    languageProvider,
                                  );
                                },
                              ),
                              const SizedBox(height: 40),
                              FutureBuilder<Map<String, int>>(
                                future: _getStats(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  int departmentsCount =
                                      snapshot.data!['departmentsCount']!;
                                  int staffCount =
                                      snapshot.data!['staffCount']!;
                                  int labcount = snapshot.data!['staffCount']!;

                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Consumer<LanguageProvider>(
                                              builder: (context,
                                                  languageProvider, child) {
                                                return _buildStatCard(
                                                    languageProvider
                                                        .getLocalizedString(
                                                            'departments_stats'),
                                                    '$departmentsCount',
                                                    languageProvider);
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Consumer<LanguageProvider>(
                                              builder: (context,
                                                  languageProvider, child) {
                                                return _buildStatCard(
                                                    languageProvider
                                                        .getLocalizedString(
                                                            'teachers_stats'),
                                                    '$staffCount',
                                                    languageProvider);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Consumer<LanguageProvider>(
                                              builder: (context,
                                                  languageProvider, child) {
                                                return _buildStatCard(
                                                    languageProvider
                                                        .getLocalizedString(
                                                            'facilities'),
                                                    (facultyData[
                                                                'Facilities'] ??
                                                            [])
                                                        .join('\n'),
                                                    languageProvider);
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFFFFF),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AllFacultyTeachersScreen(
                                          facultyData: facultyData,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Consumer<LanguageProvider>(
                                    builder:
                                        (context, languageProvider, child) {
                                      return Text(
                                        languageProvider.getLocalizedString(
                                            'all_teachers_title'),
                                        style: TextStyle(
                                          fontFamily:
                                              languageProvider.getFontFamily(),
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        textDirection:
                                            languageProvider.getTextDirection(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildSectionTitleWithIcon(
                                      languageProvider
                                          .getLocalizedString('vision'),
                                      'images/view.png',
                                      languageProvider);
                                },
                              ),
                              const SizedBox(height: 12),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildInfoCard(
                                    facultyData['vision'] ?? '',
                                    languageProvider,
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildSectionTitleWithIcon(
                                      languageProvider
                                          .getLocalizedString('mission'),
                                      'images/view.png',
                                      languageProvider);
                                },
                              ),
                              const SizedBox(height: 12),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildInfoCard(
                                    facultyData['Mission'] ?? '',
                                    languageProvider,
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildSectionTitleWithIcon(
                                      languageProvider
                                          .getLocalizedString('objectives'),
                                      'images/view.png',
                                      languageProvider);
                                },
                              ),
                              const SizedBox(height: 12),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  return _buildInfoCard(
                                    facultyData['objectiv'] ?? '',
                                    languageProvider,
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                              _buildDepartmentsSection(widget.facultyId),
                              const SizedBox(height: 30),
                              _buildGallerySection(
                                  widget.facultyId, facultyData),
                              const SizedBox(height: 30),
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
      ),
    );
  }

  Widget _buildSectionTitleWithIcon(
      String title, String iconPath, LanguageProvider languageProvider) {
    return Row(
      children: [
        Image.asset(iconPath, width: 40, height: 40),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: languageProvider.getFontFamily(),
              color: const Color(0xFF0D3B66)),
          textDirection: languageProvider.getTextDirection(),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String content, LanguageProvider languageProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16,
          fontFamily: languageProvider.getFontFamily(),
          height: 1.5,
          color: Colors.black87,
        ),
        textDirection: languageProvider.getTextDirection(),
        textAlign: languageProvider.getTextDirection() == TextDirection.rtl
            ? TextAlign.right
            : TextAlign.left,
      ),
    );
  }

  static Widget _buildStatCard(
      String title, String value, LanguageProvider languageProvider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: languageProvider.getFontFamily(),
                ),
                textDirection: languageProvider.getTextDirection(),
              ),
              Image.asset(
                'images/seo.png',
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0D3B66),
              fontFamily: languageProvider.getFontFamily(),
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsSection(String facultyId) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: languageProvider
              .getDepartmentsCollectionRef(facultyId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) return const SizedBox();
            List<DocumentSnapshot> departments = snapshot.data!.docs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return Text(
                        languageProvider.getLocalizedString('departments'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: languageProvider.getFontFamily(),
                          color: const Color(0xFF0D3B66),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> dept =
                        departments[index].data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: ListTile(
                        title: Text(dept['name'] ?? '',
                            style: const TextStyle(
                                fontFamily: 'pashto',
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DepartmentScreen(
                                facultyId: facultyId,
                                departmentId: departments[index].id,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildGallerySection(
      String facultyId, Map<String, dynamic> facultyData) {
    bool showAllImages = false;

    return StatefulBuilder(
      builder: (context, setState) {
        void _showFullImage(BuildContext context, String imageUrl, int index) {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Hero(
                  tag: 'gallery_thumb_${imageUrl.hashCode}_$index',
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Center(
              child: Text(
                'ګالري',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'pashto',
                  color: Color(0xFF0D3B66),
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 12),
            Builder(
              builder: (context) {
                List<dynamic>? galleryList = facultyData['gellery'];
                if (galleryList == null || galleryList.isEmpty) {
                  return const Text(
                    'انځورونه نشته',
                    style: TextStyle(fontFamily: 'pashto'),
                    textDirection: TextDirection.rtl,
                  );
                }

                List<String> allImages = galleryList.cast<String>();
                int imagesToShow = showAllImages
                    ? allImages.length
                    : (allImages.length >= 3 ? 3 : allImages.length);

                return Column(
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(imagesToShow, (index) {
                        String imageUrl = allImages[index];
                        return GestureDetector(
                          onTap: () => _showFullImage(context, imageUrl, index),
                          child: Hero(
                            tag: 'gallery_thumb_${imageUrl.hashCode}_$index',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                memCacheWidth: 200,
                                memCacheHeight: 200,
                                placeholder: (context, url) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.image,
                                      color: Colors.grey),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.broken_image,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    if (allImages.length > 3)
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showAllImages = !showAllImages;
                            });
                          },
                          child: Text(
                            showAllImages
                                ? 'کم انځورونه وښایه'
                                : 'ډیر انځورونه وښایه',
                            style: const TextStyle(
                              fontFamily: 'pashto',
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
