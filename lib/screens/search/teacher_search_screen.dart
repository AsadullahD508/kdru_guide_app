import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../header.dart';
import '../../language_provider.dart';
import '../../widgets/buttom_header.dart';
import '../../services/firebase_cache_service.dart';
import '../Faculty/teacher_profile_screen.dart';

class TeacherSearchScreen extends StatefulWidget {
  const TeacherSearchScreen({super.key});

  @override
  State<TeacherSearchScreen> createState() => _TeacherSearchScreenState();
}

class _TeacherSearchScreenState extends State<TeacherSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchTeachers(String query, LanguageProvider languageProvider) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _hasSearched = true;
    });

    try {
      List<Map<String, dynamic>> allTeachers = [];
      
      // Get all faculties
      final facultiesSnapshot = await languageProvider.getFacultiesCollectionRef().get();
      
      for (var facultyDoc in facultiesSnapshot.docs) {
        final facultyId = facultyDoc.id;
        final facultyData = facultyDoc.data() as Map<String, dynamic>;
        
        // Get all departments in this faculty
        final departmentsSnapshot = await languageProvider
            .getDepartmentsCollectionRef(facultyId)
            .get();
        
        for (var departmentDoc in departmentsSnapshot.docs) {
          final departmentId = departmentDoc.id;
          final departmentData = departmentDoc.data() as Map<String, dynamic>;
          
          // Get all teachers in this department
          final teachersSnapshot = await languageProvider
              .getTeachersCollectionRef(facultyId, departmentId)
              .get();
          
          for (var teacherDoc in teachersSnapshot.docs) {
            final teacherData = teacherDoc.data() as Map<String, dynamic>;
            
            // Add faculty and department info to teacher data
            allTeachers.add({
              ...teacherData,
              'id': teacherDoc.id,
              'facultyId': facultyId,
              'facultyName': facultyData['name'] ?? '',
              'departmentId': departmentId,
              'departmentName': departmentData['name'] ?? '',
            });
          }
        }
      }
      
      // Filter teachers by search query (name and email only)
      final filteredTeachers = allTeachers.where((teacher) {
        final name = (teacher['fullName'] ?? '').toString().toLowerCase();
        final email = (teacher['email'] ?? '').toString().toLowerCase();
        final searchQuery = query.toLowerCase();

        return name.contains(searchQuery) ||
               email.contains(searchQuery);
      }).toList();
      
      setState(() {
        _searchResults = filteredTeachers;
        _isSearching = false;
      });
      
    } catch (e) {
      debugPrint('Error searching teachers: $e');
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
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
                  bannerImagePath: 'images/kdr_logo.png',
                  fullText: languageProvider.getLocalizedString('search_teachers'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Search Bar
                        _buildSearchBar(languageProvider),
                        
                        const SizedBox(height: 20),
                        
                        // Search Results
                        Expanded(
                          child: _buildSearchResults(languageProvider),
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
  }

  Widget _buildSearchBar(LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        textDirection: languageProvider.getTextDirection(),
        style: TextStyle(
          fontFamily: languageProvider.getFontFamily(),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: languageProvider.getLocalizedString('search_teacher_hint'),
          hintStyle: TextStyle(
            fontFamily: languageProvider.getFontFamily(),
            color: Colors.grey.shade500,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blue.shade700,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchTeachers('', languageProvider);
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        onChanged: (value) {
          setState(() {}); // Rebuild to show/hide clear button
          _searchTeachers(value, languageProvider);
        },
        onSubmitted: (value) {
          _searchTeachers(value, languageProvider);
        },
      ),
    );
  }

  Widget _buildSearchResults(LanguageProvider languageProvider) {
    if (_isSearching) {
      return Center(
        child: ClipRect(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 12),
              Flexible(
                child: Text(
                  languageProvider.getLocalizedString('searching'),
                  style: TextStyle(
                    fontFamily: languageProvider.getFontFamily(),
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textDirection: languageProvider.getTextDirection(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_hasSearched) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: Text(
                      languageProvider.getLocalizedString('search_teachers_instruction'),
                      style: TextStyle(
                        fontFamily: languageProvider.getFontFamily(),
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: languageProvider.getTextDirection(),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 250,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_search,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: Text(
                      languageProvider.getLocalizedString('no_teachers_found'),
                      style: TextStyle(
                        fontFamily: languageProvider.getFontFamily(),
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: languageProvider.getTextDirection(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Flexible(
                    child: Text(
                      languageProvider.getLocalizedString('try_different_search'),
                      style: TextStyle(
                        fontFamily: languageProvider.getFontFamily(),
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: languageProvider.getTextDirection(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results count
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
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
                '${languageProvider.getLocalizedString('found_teachers')}: ${_searchResults.length}',
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
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final teacher = _searchResults[index];
              return _buildTeacherCard(teacher, languageProvider);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherCard(Map<String, dynamic> teacher, LanguageProvider languageProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherProfileScreen(
                  teacherId: teacher['id'] ?? '',
                  facultyId: teacher['facultyId'] ?? '',
                  departmentId: teacher['departmentId'] ?? '',
                ),
              ),
            );
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 80,
              maxHeight: 120,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Teacher Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: teacher['avatarUrl'] != null && teacher['avatarUrl'].toString().isNotEmpty
                      ? Hero(
                          tag: 'teacher_search_${teacher['id'] ?? 'unknown'}_${teacher['avatarUrl'].hashCode}',
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
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                          ),
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blue.shade300,
                          ),
                        ),
                ),

                const SizedBox(width: 16),

                // Teacher Info
                Expanded(
                  child: ClipRect(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      // Teacher Name
                      Flexible(
                        child: Text(
                          teacher['fullName'] ?? languageProvider.getLocalizedString('unknown_teacher'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          textDirection: languageProvider.getTextDirection(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 3),

                      // Position
                      if (teacher['position'] != null && teacher['position'].toString().isNotEmpty)
                        Flexible(
                          child: Text(
                            teacher['position'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade700,
                              fontFamily: languageProvider.getFontFamily(),
                              fontWeight: FontWeight.w500,
                            ),
                            textDirection: languageProvider.getTextDirection(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      const SizedBox(height: 4),

                      // Faculty and Department
                      Flexible(
                        child: Row(
                          children: [
                            Icon(
                              Icons.school,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${teacher['facultyName']} - ${teacher['departmentName']}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                textDirection: languageProvider.getTextDirection(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 3),

                      // Email
                      if (teacher['email'] != null && teacher['email'].toString().isNotEmpty)
                        Flexible(
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  teacher['email'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                    fontFamily: languageProvider.getFontFamily(),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Arrow Icon
                Icon(
                  languageProvider.getTextDirection() == TextDirection.rtl
                      ? Icons.arrow_back_ios
                      : Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
