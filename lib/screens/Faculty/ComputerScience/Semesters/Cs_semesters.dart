import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../../header.dart';
import '../../../../language_provider.dart';
import '../../../../widgets/buttom_header.dart';

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
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
              selectedIndex: 1,
            ),
            body: Column(
              children: [
                CustomHeader(
                  userName: languageProvider.getLocalizedString('guest_user'),
                  bannerImagePath: 'images/semesters.jpg',
                  fullText: languageProvider.getLocalizedString('curriculum'),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: languageProvider
                        .getDepartmentsCollectionRef(widget.facultyId)
                        .doc(widget.departmentId)
                        .collection('curriculum')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.getLocalizedString('curriculum_fetch_error'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red.shade600,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                textDirection: languageProvider.getTextDirection(),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                                languageProvider.getLocalizedString('loading_curriculum'),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                textDirection: languageProvider.getTextDirection(),
                              ),
                            ],
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school_outlined,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.getLocalizedString('no_curriculum_found'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontFamily: languageProvider.getFontFamily(),
                                ),
                                textDirection: languageProvider.getTextDirection(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      // Sort curriculum data by semester
                      List<QueryDocumentSnapshot> sortedDocs = snapshot.data!.docs.toList();
                      sortedDocs.sort((a, b) {
                        Map<String, dynamic> dataA = a.data() as Map<String, dynamic>;
                        Map<String, dynamic> dataB = b.data() as Map<String, dynamic>;

                        String semesterA = dataA['semesterName'] ?? '';
                        String semesterB = dataB['semesterName'] ?? '';

                        return _compareSemesters(semesterA, semesterB);
                      });

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
                                    gradient: LinearGradient(
                                      colors: [Colors.blue.shade700, Colors.blue.shade500],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      languageProvider.getLocalizedString('subjects'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: languageProvider.getFontFamily(),
                                      ),
                                      textDirection: languageProvider.getTextDirection(),
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
                                        border: TableBorder.all(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
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
                                              color: Colors.blue.shade100,
                                            ),
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('subject'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('code'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('category'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('credits'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('theory_hours'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('practical_hours'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('total_hours'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('department'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('prerequisites'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    languageProvider.getLocalizedString('semester'),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: languageProvider.getFontFamily(),
                                                    ),
                                                    textDirection: languageProvider.getTextDirection(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ...sortedDocs.map((doc) {
                                            Map<String, dynamic> subject =
                                                doc.data() as Map<String, dynamic>;
                                            return TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      subject['subjectName'] ?? '',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: languageProvider.getFontFamily(),
                                                      ),
                                                      textDirection: languageProvider.getTextDirection(),
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
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
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
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek']
                                                            ['creditNumber']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek']
                                                            ['theoryHours']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek']
                                                            ['practicalHours']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['creditHoursPerWeek']
                                                            ['totalHours']
                                                        ?.toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['inCharge'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['prerequisites'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                subject['semesterName'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: languageProvider.getFontFamily(),
                                                ),
                                                textDirection: languageProvider.getTextDirection(),
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _compareSemesters(String semesterA, String semesterB) {
    // Extract year and semester number from semester names
    Map<String, int> semesterInfoA = _extractSemesterInfo(semesterA);
    Map<String, int> semesterInfoB = _extractSemesterInfo(semesterB);

    // First compare by year
    int yearComparison = semesterInfoA['year']!.compareTo(semesterInfoB['year']!);
    if (yearComparison != 0) {
      return yearComparison;
    }

    // If years are equal, compare by semester number
    return semesterInfoA['semester']!.compareTo(semesterInfoB['semester']!);
  }

  Map<String, int> _extractSemesterInfo(String semesterName) {
    // Default values
    int year = 1;
    int semester = 1;

    String lowerSemester = semesterName.toLowerCase();

    // Extract year information
    if (lowerSemester.contains('first') || lowerSemester.contains('لومړی') || lowerSemester.contains('اول')) {
      year = 1;
    } else if (lowerSemester.contains('second') || lowerSemester.contains('دویم') || lowerSemester.contains('دوم')) {
      year = 2;
    } else if (lowerSemester.contains('third') || lowerSemester.contains('دریم') || lowerSemester.contains('سوم')) {
      year = 3;
    } else if (lowerSemester.contains('fourth') || lowerSemester.contains('څلورم') || lowerSemester.contains('چهارم')) {
      year = 4;
    } else if (lowerSemester.contains('fifth') || lowerSemester.contains('پنځم') || lowerSemester.contains('پنجم')) {
      year = 5;
    }

    // Extract semester number (1 or 2)
    if (lowerSemester.contains('semester 1') ||
        lowerSemester.contains('semester1') ||
        lowerSemester.contains('سمسټر ۱') ||
        lowerSemester.contains('سمستر ۱') ||
        lowerSemester.contains('نیمسال اول') ||
        (lowerSemester.contains('semester') && lowerSemester.contains('1'))) {
      semester = 1;
    } else if (lowerSemester.contains('semester 2') ||
               lowerSemester.contains('semester2') ||
               lowerSemester.contains('سمسټر ۲') ||
               lowerSemester.contains('سمستر ۲') ||
               lowerSemester.contains('نیمسال دوم') ||
               (lowerSemester.contains('semester') && lowerSemester.contains('2'))) {
      semester = 2;
    }

    return {'year': year, 'semester': semester};
  }
}
