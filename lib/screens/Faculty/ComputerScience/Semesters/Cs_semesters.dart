import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../../header.dart';
import '../../../../language_provider.dart';

class CurriculumScreen extends StatefulWidget {
  final String facultyId;
  final String departmentId;

  const CurriculumScreen({
    Key? key,
    required this.facultyId,
    required this.departmentId,
  }) : super(key: key);

  @override
  _CurriculumScreenState createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  int expandedIndex = -1;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        children: [
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return CustomHeader(
                userName: languageProvider.getLocalizedString('guest_user'),
                bannerImagePath: 'images/semesters.jpg',
                fullText: languageProvider.getLocalizedString('semesters_title'),
              );
            },
          ),
          Expanded(
            child: Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
                return StreamBuilder<QuerySnapshot>(
                  stream: languageProvider
                      .getDepartmentsCollectionRef(widget.facultyId)
                      .doc(widget.departmentId)
                      .collection('subjects')
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('د معلوماتو په راوړلو کې ستونزه پیدا شوه'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('هیڅ مضمون ونه موندل شو'),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.teal[700],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            child: ListTile(
                              title: const Text(
                                'مضامین',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'pashto',
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  expandedIndex == 0
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    expandedIndex = expandedIndex == 0 ? -1 : 0;
                                  });
                                },
                              ),
                            ),
                          ),
                          if (expandedIndex == 0)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Table(
                                  border: TableBorder.all(),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: const {
                                    0: FixedColumnWidth(150),
                                    1: FixedColumnWidth(80),
                                    2: FixedColumnWidth(100),
                                    3: FixedColumnWidth(80),
                                    4: FixedColumnWidth(100),
                                    5: FixedColumnWidth(100),
                                    6: FixedColumnWidth(100),
                                    7: FixedColumnWidth(150),
                                    8: FixedColumnWidth(150),
                                    9: FixedColumnWidth(100),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                      ),
                                      children: const [
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'مضمون',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'کوډ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'کټګوري',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'کریډټ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'نظري',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'عملي',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'ټول',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'څانګه',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'پیش شرط',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'سمسټر',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'pashto',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...snapshot.data!.docs.map((doc) {
                                      Map<String, dynamic> subject =
                                          doc.data() as Map<String, dynamic>;
                                      return TableRow(
                                        children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['subjectName'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['subjectCode'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['category'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek'][0]
                                                            ['creditNumber']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek'][0]
                                                            ['theoryHours']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek'][0]
                                                            ['practicalHours']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek'][0]
                                                            ['totalHours']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['inCharge'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['prerequisites'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['semesterName'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'pashto',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
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
