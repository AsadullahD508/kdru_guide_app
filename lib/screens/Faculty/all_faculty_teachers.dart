import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../language_provider.dart';
import '../../header.dart';
import '../../widgets/buttom_header.dart';
import '../../services/firebase_cache_service.dart';
import '../../widgets/cache_status_widget.dart';
import 'teacher_profile_screen.dart';

class AllFacultyTeachersScreen extends StatefulWidget {
  final Map<String, dynamic> facultyData;

  const AllFacultyTeachersScreen({
    Key? key,
    required this.facultyData,
  }) : super(key: key);

  @override
  State<AllFacultyTeachersScreen> createState() => _AllFacultyTeachersScreenState();
}

class _AllFacultyTeachersScreenState extends State<AllFacultyTeachersScreen> {
  int _selectedIndex = 1;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fetch all teachers from all departments within the faculty
  Future<List<Map<String, dynamic>>> _getAllFacultyTeachers(LanguageProvider languageProvider) async {
    try {
      final facultyId = widget.facultyData['id'] ?? '';
      debugPrint('🔍 Fetching all teachers for faculty: $facultyId');

      List<Map<String, dynamic>> allTeachers = [];

      // First, get all departments in this faculty
      final departmentsSnapshot = await languageProvider
          .getDepartmentsCollectionRef(facultyId)
          .get();

      debugPrint('📚 Found ${departmentsSnapshot.docs.length} departments in faculty $facultyId');

      // Then, get teachers from each department
      for (var departmentDoc in departmentsSnapshot.docs) {
        try {
          final teachersSnapshot = await languageProvider
              .getTeachersCollectionRef(facultyId, departmentDoc.id)
              .get();

          debugPrint('👨‍🏫 Found ${teachersSnapshot.docs.length} teachers in department ${departmentDoc.id}');

          // Add teachers with department info
          for (var teacherDoc in teachersSnapshot.docs) {
            final teacherData = teacherDoc.data() as Map<String, dynamic>;
            allTeachers.add({
              ...teacherData,
              'id': teacherDoc.id,
              'departmentId': departmentDoc.id,
              'departmentName': (departmentDoc.data() as Map<String, dynamic>)['name'] ?? departmentDoc.id,
              'facultyId': facultyId,
            });
          }
        } catch (e) {
          debugPrint('❌ Error fetching teachers from department ${departmentDoc.id}: $e');
          // Try alternative collection name for compatibility
          try {
            final teachersSnapshot = await languageProvider
                .getDepartmentsCollectionRef(facultyId)
                .doc(departmentDoc.id)
                .collection('teacher')
                .get();

            debugPrint('👨‍🏫 Found ${teachersSnapshot.docs.length} teachers in "teacher" collection for department ${departmentDoc.id}');

            for (var teacherDoc in teachersSnapshot.docs) {
              final teacherData = teacherDoc.data() as Map<String, dynamic>;
              allTeachers.add({
                ...teacherData,
                'id': teacherDoc.id,
                'departmentId': departmentDoc.id,
                'departmentName': (departmentDoc.data() as Map<String, dynamic>)['name'] ?? departmentDoc.id,
                'facultyId': facultyId,
              });
            }
          } catch (e2) {
            debugPrint('❌ Error fetching from "teacher" collection in department ${departmentDoc.id}: $e2');
          }
        }
      }

      // Also try faculty-level teachers collection for compatibility
      try {
        final facultyTeachersSnapshot = await languageProvider
            .getFacultiesCollectionRef()
            .doc(facultyId)
            .collection('teachers')
            .get();

        debugPrint('👨‍🏫 Found ${facultyTeachersSnapshot.docs.length} teachers at faculty level');

        for (var teacherDoc in facultyTeachersSnapshot.docs) {
          final teacherData = teacherDoc.data() as Map<String, dynamic>;
          allTeachers.add({
            ...teacherData,
            'id': teacherDoc.id,
            'departmentId': '', // No specific department
            'departmentName': languageProvider.getLocalizedString('faculty_level'),
            'facultyId': facultyId,
          });
        }
      } catch (e) {
        debugPrint('ℹ️ No faculty-level teachers collection found: $e');
      }

      debugPrint('✅ Total teachers found: ${allTeachers.length}');
      return allTeachers;
    } catch (e) {
      debugPrint('❌ Error fetching faculty teachers: $e');
      return [];
    }
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Directionality(
          textDirection: languageProvider.getTextDirection(),
          child: Scaffold(
            backgroundColor: Colors.lightBlue[50],
            bottomNavigationBar: CustomBottomNavBar(
              onItemTapped: _onItemTapped,
              selectedIndex: _selectedIndex,
            ),
            body: Column(
              children: [
                CustomHeader(
                  userName: languageProvider.getLocalizedString('guest_user'),
                  bannerImagePath: widget.facultyData['logo'] ?? 'images/kdr_logo.png',
                  fullText: '${widget.facultyData['name'] ?? languageProvider.getLocalizedString('faculty')} - ${languageProvider.getLocalizedString('all_teachers_title')}',
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _getAllFacultyTeachers(languageProvider),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWithCacheWidget();
                      }

                      if (snapshot.hasError) {
                        return ErrorWithRetryWidget(
                          error: snapshot.error.toString(),
                          onRetry: () {
                            (context as Element).markNeedsBuild();
                          },
                          onClearCache: () async {
                            await FirebaseCacheService.instance.clearCache();
                            if (context.mounted) {
                              (context as Element).markNeedsBuild();
                            }
                          },
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_off,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.getLocalizedString('no_teachers_found'),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                textDirection: languageProvider.getTextDirection(),
                              ),
                            ],
                          ),
                        );
                      }

                      // Get teachers list from future
                      final teachers = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cache Status Indicator
                            // CacheStatusWidget not applicable for FutureBuilder
                            const SizedBox.shrink(),

                            // Header with count
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: Colors.blue.shade700,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${languageProvider.getLocalizedString('total_teachers')}: ${teachers.length}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade700,
                                      fontFamily: languageProvider.getFontFamily(),
                                    ),
                                    textDirection: languageProvider.getTextDirection(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Teachers list
                            Expanded(
                              child: ListView.builder(
                                itemCount: teachers.length,
                                itemBuilder: (context, index) {
                                  final teacher = teachers[index];
                                  return _buildTeacherCard(teacher, languageProvider);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeacherCard(Map<String, dynamic> teacher, LanguageProvider languageProvider) {
    return GestureDetector(
      onTap: () {
        // Only navigate if we have a valid departmentId
        final departmentId = teacher['departmentId'] ?? '';
        if (departmentId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherProfileScreen(
                teacherId: teacher['id'] ?? '',
                facultyId: widget.facultyData['id'] ?? '',
                departmentId: departmentId,
              ),
            ),
          );
        } else {
          // Show message for faculty-level teachers
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                languageProvider.getLocalizedString('teacher_profile_not_available'),
                style: TextStyle(
                  fontFamily: languageProvider.getFontFamily(),
                ),
                textDirection: languageProvider.getTextDirection(),
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Teacher Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: teacher['avatarUrl'] != null && teacher['avatarUrl'].toString().isNotEmpty
                    ? Hero(
                        tag: 'teacher_avatar_${teacher['id'] ?? 'unknown'}_${teacher['avatarUrl'].hashCode}',
                        child: CachedNetworkImage(
                          imageUrl: teacher['avatarUrl'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          memCacheWidth: 140,
                          memCacheHeight: 140,
                          placeholder: (context, url) => Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey.shade400,
                              size: 35,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade400,
                          size: 35,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              // Teacher Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher['fullName'] ?? teacher['name'] ?? languageProvider.getLocalizedString('unknown'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: languageProvider.getFontFamily(),
                      ),
                      textDirection: languageProvider.getTextDirection(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      teacher['departmentName'] ?? languageProvider.getLocalizedString('unknown'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade600,
                        fontFamily: languageProvider.getFontFamily(),
                      ),
                      textDirection: languageProvider.getTextDirection(),
                    ),
                    if (teacher['degree'] != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            teacher['degree'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontFamily: languageProvider.getFontFamily(),
                            ),
                            textDirection: languageProvider.getTextDirection(),
                          ),
                        ],
                      ),
                    ],
                    if (teacher['GraduatedSchool'] != null && teacher['GraduatedSchool'].toString().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 14,
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${languageProvider.getLocalizedString('graduated_school')}: ${teacher['GraduatedSchool']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontFamily: languageProvider.getFontFamily(),
                              ),
                              textDirection: languageProvider.getTextDirection(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (teacher['rank'] != null && teacher['rank'].toString().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.orange.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            teacher['rank'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontFamily: languageProvider.getFontFamily(),
                            ),
                            textDirection: languageProvider.getTextDirection(),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
