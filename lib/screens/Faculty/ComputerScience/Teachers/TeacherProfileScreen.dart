import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeacherProfileScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final teacherDocRef = FirebaseFirestore.instance
        .collection('Kandahar University')
        .doc('kdru')
        .collection('faculties')
        .doc(facultyId)
        .collection('departments')
        .doc(departmentId)
        .collection('teachers')
        .doc(teacherId);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: FutureBuilder<DocumentSnapshot>(
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

            final teacherData = snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Profile Card
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
                          teacherData['fullName'] ?? 'نامعلوم',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          teacherData['address'] ?? 'استاد',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
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
                                    fontSize: 14, fontWeight: FontWeight.bold),
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
                                    fontSize: 14, fontWeight: FontWeight.bold),
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
                                    fontSize: 14, fontWeight: FontWeight.bold),
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

                  // Researches Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'څیړڼی',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        _buildResearchItem(
                          title:
                              'عنوان: ${teacherData['publishResearches'] ?? 'نامعلوم'}',
                          publishYear:
                              'د خپریدو کال: ${teacherData['research'] ?? 'نامعلوم'}',
                          publishLink:
                              '   د خپریدیو لینک: ${teacherData['research'] ?? 'نامعلوم'}',
                          where:
                              '   د خپریدیو لینک: ${teacherData['research'] ?? 'نامعلوم'}',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Contact Card
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
                                  const Text('Email',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    teacherData['email'] ?? 'نامعلوم',
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
                                  const Text('Phone',
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

                  // Skills Section
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResearchItem({
    required String title,
    required String publishYear,
    required String publishLink,
    required String where,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(publishYear, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 6),
        Text(publishLink, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 6),
        Text(where, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget _buildSkillCard(String skillName, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(height: 4),
          Text(skillName,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
