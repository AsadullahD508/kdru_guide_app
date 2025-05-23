import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../header.dart';
import '../../../widgets/buttom_header.dart';
import '../../Departement/Departement.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Cs_Department/CS_department.dart';
import 'Teachers/Cs_teachers.dart';

class FacultyScreen extends StatefulWidget {
  final String facultyId;

  const FacultyScreen(
      {Key? key, required this.facultyId, required String section})
      : super(key: key);

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: selectedIndex,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('Kandahar University')
            .doc('kdru')
            .collection('faculties')
            .doc(widget.facultyId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading faculty data'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Faculty not found'));
          }

          Map<String, dynamic> facultyData =
              snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            children: [
              CustomHeader(
                userName: 'Guest User',
                bannerImagePath: facultyData['backgroundUrl'] ?? '',
                fullText: facultyData['name'] ?? '',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildInfoSection(
                            'لید لوری', facultyData['vision'] ?? ''),
                        const SizedBox(height: 20),
                        _buildInfoSection('موخه', facultyData['mission'] ?? ''),
                        const SizedBox(height: 20),
                        _buildDepartmentsSection(widget.facultyId),
                        const SizedBox(height: 20),
                        _buildStaffSection(widget.facultyId),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'pashto',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              fontFamily: 'pashto',
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsSection(String facultyId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Kandahar University')
          .doc('kdru')
          .collection('faculties')
          .doc(facultyId)
          .collection('departments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox();
        }

        List<DocumentSnapshot> departments = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'څانګې',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'pashto',
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
                  child: ListTile(
                    title: Text(
                      dept['name'] ?? '',
                      style: const TextStyle(fontFamily: 'pashto'),
                    ),
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
  }

  Widget _buildStaffSection(String facultyId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Kandahar University')
          .doc('kdru')
          .collection('faculties')
          .doc(facultyId)
          .collection('staff')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox();
        }

        List<DocumentSnapshot> staffMembers = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'کارکوونکي',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'pashto',
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: staffMembers.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> staff =
                    staffMembers[index].data() as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(staff['photoUrl'] ?? ''),
                    ),
                    title: Text(
                      staff['name'] ?? '',
                      style: const TextStyle(fontFamily: 'pashto'),
                    ),
                    subtitle: Text(
                      staff['position'] ?? '',
                      style: const TextStyle(fontFamily: 'pashto'),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
