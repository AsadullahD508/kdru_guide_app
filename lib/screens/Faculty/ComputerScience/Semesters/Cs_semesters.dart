import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../header.dart';

class SemesterScreen extends StatelessWidget {
  final String facultyId;
  final String departmentId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SemesterScreen({
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
            bannerImagePath: 'images/semesters.jpg',
            fullText: 'سمسټرونه',
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
                  .collection('semesters')
                  .orderBy('number')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading semesters'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No semesters found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot semester = snapshot.data!.docs[index];
                    Map<String, dynamic> semesterData =
                        semester.data() as Map<String, dynamic>;
                    List<dynamic> subjects = semesterData['subjects'] ?? [];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ExpansionTile(
                        title: Text(
                          'سمسټر ${semesterData['number']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'pashto',
                          ),
                        ),
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'مضمون',
                                    style: TextStyle(fontFamily: 'pashto'),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'کوډ',
                                    style: TextStyle(fontFamily: 'pashto'),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'کریډټ',
                                    style: TextStyle(fontFamily: 'pashto'),
                                  ),
                                ),
                              ],
                              rows: subjects.map<DataRow>((subject) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        subject['name'] ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'pashto',
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        subject['code'] ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'pashto',
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        subject['credits'].toString(),
                                        style: const TextStyle(
                                          fontFamily: 'pashto',
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
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
