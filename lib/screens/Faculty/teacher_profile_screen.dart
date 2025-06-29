import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../header.dart';
import '../../widgets/buttom_header.dart';
import '../../language_provider.dart';
import '../../utils/responsive_utils.dart';
import '../../services/firebase_cache_service.dart';

class TeacherProfileScreen extends StatefulWidget {
  final String teacherId;
  final String facultyId;
  final String departmentId;

  const TeacherProfileScreen({
    Key? key,
    required this.teacherId,
    required this.facultyId,
    required this.departmentId,
  }) : super(key: key);

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  int _selectedIndex = 1;
  Map<String, dynamic>? facultyData;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFacultyData();
  }

  Future<void> _fetchFacultyData() async {
    try {
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      final docId = FirebaseCacheService.instance.getDocumentIdFromLanguage(languageProvider.currentLanguage);

      final facultyDoc = await FirebaseFirestore.instance
          .collection('Kandahar University')
          .doc(docId)
          .collection('faculties')
          .doc(widget.facultyId)
          .get();

      if (mounted && facultyDoc.exists) {
        setState(() {
          facultyData = facultyDoc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      debugPrint('Error fetching faculty data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final docId = FirebaseCacheService.instance.getDocumentIdFromLanguage(languageProvider.currentLanguage);
        final teacherDocRef = FirebaseFirestore.instance
            .collection('Kandahar University')
            .doc(docId)
            .collection('faculties')
            .doc(widget.facultyId)
            .collection('departments')
            .doc(widget.departmentId)
            .collection('teachers')
            .doc(widget.teacherId);

        return Directionality(
          textDirection: languageProvider.getTextDirection(),
          child: Scaffold(
            backgroundColor: Colors.lightBlue[50],
            bottomNavigationBar: CustomBottomNavBar(
              onItemTapped: _onItemTapped,
              selectedIndex: 1,
            ),
            body: Column(
              children: [
                CustomHeader(
                  userName: languageProvider.getLocalizedString('guest_user'),
                  bannerImagePath: facultyData?['logo'] ?? 'images/kdr_logo.png',
                  fullText: facultyData?['name'] ?? languageProvider.getLocalizedString('faculty'),
                ),
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    key: ValueKey('${languageProvider.currentLanguage}_${widget.teacherId}'), // Rebuild when language changes
                    future: teacherDocRef.get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            languageProvider.getLocalizedString('teacher_data_error'),
                            style: TextStyle(
                              fontFamily: languageProvider.getFontFamily(),
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textDirection: languageProvider.getTextDirection(),
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.getLocalizedString('loading_teacher_data'),
                                style: TextStyle(
                                  fontFamily: languageProvider.getFontFamily(),
                                  fontSize: 16,
                                ),
                                textDirection: languageProvider.getTextDirection(),
                              ),
                            ],
                          ),
                        );
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Center(
                          child: Text(
                            languageProvider.getLocalizedString('teacher_not_found'),
                            style: TextStyle(
                              fontFamily: languageProvider.getFontFamily(),
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textDirection: languageProvider.getTextDirection(),
                          ),
                        );
                      }

            final teacherData = snapshot.data!.data() as Map<String, dynamic>;
            final List<dynamic> researchEntries =
                teacherData['researchEntries'] ?? [];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(70),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.lightBlue.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.lightBlue, width: 3),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: teacherData['avatarUrl'] != null
                                ? CachedNetworkImageProvider(
                                    teacherData['avatarUrl'])
                                : null,
                            child: teacherData['avatarUrl'] == null
                                ? const Icon(Icons.person,
                                    size: 50, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          teacherData['fullName'] ?? languageProvider.getLocalizedString('unknown'),
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adjustFontSizeForLanguage(14, languageProvider.currentLanguage),
                            fontWeight: FontWeight.bold,
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: languageProvider.getTextDirection(),
                        ),
                        Text(
                          teacherData['address'] ?? languageProvider.getLocalizedString('instructor'),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: languageProvider.getTextDirection(),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.school,
                                color: Colors.blue, size: 20),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${languageProvider.getLocalizedString('academic_rank')}: ${teacherData['educationRank'] ?? languageProvider.getLocalizedString('unknown')}',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.adjustFontSizeForLanguage(12, languageProvider.currentLanguage),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: languageProvider.getTextDirection(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.workspace_premium,
                                color: Colors.orange, size: 20),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${languageProvider.getLocalizedString('degree')}: ${teacherData['degree'] ?? languageProvider.getLocalizedString('unknown')}',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.adjustFontSizeForLanguage(12, languageProvider.currentLanguage),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: languageProvider.getTextDirection(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Graduated School
                        if (teacherData['GraduatedSchool'] != null && teacherData['GraduatedSchool'].toString().isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.school_outlined,
                                  color: Colors.green, size: 20),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  '${languageProvider.getLocalizedString('graduated_school')}: ${teacherData['GraduatedSchool']}',
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.adjustFontSizeForLanguage(12, languageProvider.currentLanguage),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: languageProvider.getFontFamily(),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: languageProvider.getTextDirection(),
                                ),
                              ),
                            ],
                          ),
                        if (teacherData['GraduatedSchool'] != null && teacherData['GraduatedSchool'].toString().isNotEmpty)
                          const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.apartment,
                                color: Colors.lightBlue, size: 20),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${languageProvider.getLocalizedString('department')}: ${teacherData['departmentName'] ?? languageProvider.getLocalizedString('unknown')}',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.adjustFontSizeForLanguage(12, languageProvider.currentLanguage),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: languageProvider.getTextDirection(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          languageProvider.getLocalizedString('research'),
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adjustFontSizeForLanguage(18, languageProvider.currentLanguage),
                            fontWeight: FontWeight.bold,
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          textDirection: languageProvider.getTextDirection(),
                        ),
                        const SizedBox(height: 12),
                        researchEntries.isEmpty
                            ? Text(
                                languageProvider.getLocalizedString('no_research_available'),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey.shade600,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                textDirection: languageProvider.getTextDirection(),
                              )
                            : Column(
                                children: researchEntries.map((research) {
                                  final Map<String, dynamic> r =
                                      Map<String, dynamic>.from(research);
                                  return _buildResearchItem(
                                    id: r['id'] ?? '',
                                    title: r['title'] ?? languageProvider.getLocalizedString('unknown'),
                                    publishYear: r['year'] ?? languageProvider.getLocalizedString('unknown'),
                                    publishLink: r['journalUrl'] ?? '',
                                    groupWorker: r['groupWorker'] ?? '',
                                    languageProvider: languageProvider,
                                  );
                                }).toList(),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.email,
                                color: Colors.blue, size: 34),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    languageProvider.getLocalizedString('email'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: languageProvider.getFontFamily(),
                                    ),
                                    textDirection: languageProvider.getTextDirection(),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final email = teacherData['email'];
                                      if (email != null) {
                                        _launchUrlInBrowser("mailto:$email");
                                      }
                                    },
                                    child: Text(
                                      teacherData['email'] ?? languageProvider.getLocalizedString('unknown'),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontFamily: languageProvider.getFontFamily(),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: languageProvider.getTextDirection(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.phone,
                                color: Colors.green, size: 34),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    languageProvider.getLocalizedString('phone'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: languageProvider.getFontFamily(),
                                    ),
                                    textDirection: languageProvider.getTextDirection(),
                                  ),
                                  Text(
                                    teacherData['phone'] ?? languageProvider.getLocalizedString('unknown'),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: languageProvider.getFontFamily(),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: languageProvider.getTextDirection(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
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

  Widget _buildResearchItem({
    required String id,
    required String title,
    required String publishYear,
    required String publishLink,
    required String groupWorker,
    required LanguageProvider languageProvider,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: languageProvider.getTextDirection() == TextDirection.rtl
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Research Title
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0D3B66),
              fontFamily: languageProvider.getFontFamily(),
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          const SizedBox(height: 8),

          // Publication Year
          Row(
            children: languageProvider.getTextDirection() == TextDirection.rtl
                ? [
                    Expanded(
                      child: Text(
                        '${languageProvider.getLocalizedString('year')}: $publishYear',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ]
                : [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${languageProvider.getLocalizedString('year')}: $publishYear',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
          ),

          // Group Worker (if available)
          if (groupWorker.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: languageProvider.getTextDirection() == TextDirection.rtl
                  ? [
                      Expanded(
                        child: Text(
                          '${languageProvider.getLocalizedString('researchers')}: $groupWorker',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          textDirection: languageProvider.getTextDirection(),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.group,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                    ]
                  : [
                      Icon(
                        Icons.group,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${languageProvider.getLocalizedString('researchers')}: $groupWorker',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          textDirection: languageProvider.getTextDirection(),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
            ),
          ],

          // Journal Link (if available)
          if (publishLink.isNotEmpty) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _launchUrlInBrowser(publishLink),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: languageProvider.getTextDirection() == TextDirection.rtl
                      ? [
                          Text(
                            languageProvider.getLocalizedString('view_research'),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                              fontFamily: languageProvider.getFontFamily(),
                            ),
                            textDirection: languageProvider.getTextDirection(),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                        ]
                      : [
                          Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            languageProvider.getLocalizedString('view_research'),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                              fontFamily: languageProvider.getFontFamily(),
                            ),
                            textDirection: languageProvider.getTextDirection(),
                          ),
                        ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _launchUrlInBrowser(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      )) {
        debugPrint('لینک خلاصه نشو: $urlString');
      }
    } catch (e) {
      debugPrint('د لینک په خلاصولو کې ستونزه: $e');
    }
  }
}