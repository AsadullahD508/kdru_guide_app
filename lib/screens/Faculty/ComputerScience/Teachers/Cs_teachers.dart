import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../header.dart';

class TeachersScreen extends StatelessWidget {
  final String facultyId;
  final String departmentId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TeachersScreen({
    Key? key,
    required this.facultyId,
    required this.departmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        children: [
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/teachers.jpg',
            fullText: 'استادان',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
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
                  return const Center(child: Text('Error loading teachers'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No teachers found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot teacher = snapshot.data!.docs[index];
                    Map<String, dynamic> teacherData =
                        teacher.data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(teacherData['photoUrl'] ?? ''),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    teacherData['name'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'pashto',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    teacherData['position'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontFamily: 'pashto',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    teacherData['education'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'pashto',
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }
}
