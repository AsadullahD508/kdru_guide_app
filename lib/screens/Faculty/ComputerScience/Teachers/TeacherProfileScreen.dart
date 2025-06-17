import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../header.dart';
import '../../../../widgets/buttom_header.dart';

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
      final facultyDoc = await FirebaseFirestore.instance
          .collection('Kandahar University')
          .doc('kdru')
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
    final teacherDocRef = FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .collection('faculties')
        .doc(widget.facultyId)
        .collection('departments')
        .doc(widget.departmentId)
        .collection('teachers')
        .doc(widget.teacherId);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: _onItemTapped,
          selectedIndex: 1,
        ),
        body: Column(
          children: [
            CustomHeader(
              userName: 'Guest User',
              bannerImagePath: facultyData?['logo'] ?? 'images/kdr_logo.png',
              fullText: facultyData?['name'] ?? 'پوهنځی',
            ),
            Expanded(
              child: FutureBuilder<DocumentSnapshot>(
                future: teacherDocRef.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'د معلوماتو په لوستلو کې ستونزه رامنځته شوه.',
                        style: TextStyle(fontFamily: 'pashto'),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(
                      child: Text(
                        'استاد ونه موندل شو.',
                        style: TextStyle(fontFamily: 'pashto'),
                      ),
                    );
                  }

                  final teacherData =
                      snapshot.data!.data() as Map<String, dynamic>;
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
                                  border: Border.all(
                                      color: Colors.lightBlue, width: 3),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      teacherData['avatarUrl'] != null
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
                                teacherData['fullName'] ?? 'نامعلوم',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                teacherData['address'] ?? 'استاد',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                                      'علمي رتبه : ${teacherData['departmentName'] ?? 'نامعلوم'}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                      'درجه: ${teacherData['degree'] ?? 'نامعلوم'}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                      'ځانکه: ${teacherData['departmentName'] ?? 'نامعلوم'}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                              const Text(
                                'څیړنې',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              ...researchAreas.map((research) {
                                final Map<String, dynamic> r =
                                    Map<String, dynamic>.from(research);
                                return _buildResearchItem(
                                  title: 'عنوان: ${r['title'] ?? 'نامعلوم'}',
                                  publishYear: 'کال: ${r['year'] ?? 'نامعلوم'}',
                                  publishLink: r['journalUrl'] ?? '',
                                  researchers:
                                      'څیړونکي: ${r['researchers'] ?? 'نامعلوم'}',
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('برېښنالیک',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        GestureDetector(
                                          onTap: () {
                                            final email = teacherData['email'];
                                            if (email != null) {
                                              _launchUrlInBrowser(
                                                  "mailto:$email");
                                            }
                                          },
                                          child: Text(
                                            teacherData['email'] ?? 'نامعلوم',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
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
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Icons.phone,
                                      color: Colors.green, size: 34),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('تلیفون',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          teacherData['phone'] ?? 'نامعلوم',
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
  }

  Widget _buildResearchItem({
    required String title,
    required String publishYear,
    required String publishLink,
    required String researchers,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(publishYear,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
          if (publishLink.isNotEmpty)
            InkWell(
              onTap: () => _launchUrlInBrowser(publishLink),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  publishLink,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          Text(researchers,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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
