import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../header.dart';
import '../../widgets/buttom_header.dart';
import '../../language_provider.dart';
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
            final List<dynamic> researchAreas =
                teacherData['researchAreas'] ?? [];

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
                            fontSize: 22,
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
                                '${languageProvider.getLocalizedString('academic_rank')}: ${teacherData['departmentName'] ?? languageProvider.getLocalizedString('unknown')}',
                                style: TextStyle(
                                  fontSize: 14,
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
                                  fontSize: 14,
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
                            const Icon(Icons.apartment,
                                color: Colors.lightBlue, size: 20),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${languageProvider.getLocalizedString('department')}: ${teacherData['departmentName'] ?? languageProvider.getLocalizedString('unknown')}',
                                style: TextStyle(
                                  fontSize: 14,
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: languageProvider.getFontFamily(),
                          ),
                          textDirection: languageProvider.getTextDirection(),
                        ),
                        const SizedBox(height: 12),
                        ...researchAreas.map((research) {
                          final Map<String, dynamic> r =
                              Map<String, dynamic>.from(research);
                          return _buildResearchItem(
                            title: '${languageProvider.getLocalizedString('title')}: ${r['title'] ?? languageProvider.getLocalizedString('unknown')}',
                            publishYear: '${languageProvider.getLocalizedString('year')}: ${r['year'] ?? languageProvider.getLocalizedString('unknown')}',
                            publishLink: r['journalUrl'] ?? '',
                            researchers: '${languageProvider.getLocalizedString('researchers')}: ${r['researchers'] ?? languageProvider.getLocalizedString('unknown')}',
                            languageProvider: languageProvider,
                          );
                        }).toList(),
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
    required String title,
    required String publishYear,
    required String publishLink,
    required String researchers,
    required LanguageProvider languageProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: languageProvider.getFontFamily(),
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          Text(
            publishYear,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: languageProvider.getFontFamily(),
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          if (publishLink.isNotEmpty)
            InkWell(
              onTap: () => _launchUrlInBrowser(publishLink),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  publishLink,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontFamily: languageProvider.getFontFamily(),
                  ),
                  textDirection: languageProvider.getTextDirection(),
                ),
              ),
            ),
          Text(
            researchers,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: languageProvider.getFontFamily(),
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
          const Divider(),
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