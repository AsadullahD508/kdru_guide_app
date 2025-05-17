import 'package:flutter/material.dart';

// Alias the conflicting imports:
import 'package:Kdru_Guide_app/header.dart' as header;
import 'package:Kdru_Guide_app/screens/Faculty/ComputerScience/Semesters/Cs_semesters.dart'
    as semesters;

class CurriculumScreen extends StatefulWidget {
  @override
  _CurriculumScreenState createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  int expandedIndex = -1;

  final List<Map<String, dynamic>> semesterData = List.generate(8, (index) {
    return {
      'title': 'Civil Engineering - Semester ${index + 1}',
      'books': [
        [
          '1',
          'Subject ${index + 1}-1',
          'CE-${index + 1}01',
          'Basics',
          '2',
          '2',
          '4',
          '3',
          'Engineering Faculty'
        ],
        [
          '2',
          'Subject ${index + 1}-2',
          'CE-${index + 1}02',
          'Collegiate',
          '3',
          '0',
          '3',
          '3',
          'Sharia Faculty'
        ],
        [
          '3',
          'Subject ${index + 1}-3',
          'CE-${index + 1}03',
          'Basics',
          '2',
          '1',
          '3',
          '2',
          'Engineering Faculty'
        ],
        [
          '4',
          'Subject ${index + 1}-4',
          'CE-${index + 1}04',
          'Basics',
          '3',
          '2',
          '5',
          '4',
          'Architecture Dept.'
        ],
      ],
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        children: [
          // Use the CustomHeader from header.dart
          const header.CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'کمپیوټر ساینس پوهنځي ته ښه راغلاست',
          ),

          // Expanded ListView for semester cards
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: semesterData.length,
              itemBuilder: (context, index) {
                final semester = semesterData[index];
                final isExpanded = expandedIndex == index;

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.teal[700],
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: ListTile(
                          title: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                            style: TextStyle(
                              color: isExpanded
                                  ? Colors.yellow[200]
                                  : Colors.white,
                              fontSize: isExpanded ? 18 : 16,
                              fontWeight: isExpanded
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            child: Text(semester['title']),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                expandedIndex = isExpanded ? -1 : index;
                              });
                            },
                          ),
                        ),
                      ),
                      AnimatedCrossFade(
                        firstChild: SizedBox.shrink(),
                        secondChild: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Table(
                              border: TableBorder.all(),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FixedColumnWidth(30),
                                1: FixedColumnWidth(120),
                                2: FixedColumnWidth(80),
                                3: FixedColumnWidth(80),
                                4: FixedColumnWidth(50),
                                5: FixedColumnWidth(62),
                                6: FixedColumnWidth(45),
                                7: FixedColumnWidth(65),
                                8: FixedColumnWidth(150),
                              },
                              children: [
                                TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.grey[300]),
                                  children: [
                                    tableCell('No'),
                                    tableCell('Subject'),
                                    tableCell('Code'),
                                    tableCell('Category'),
                                    tableCell('Thory'),
                                    tableCell('Practical'),
                                    tableCell('Total'),
                                    tableCell('Credit'),
                                    tableCell('In-Charge Dept.'),
                                  ],
                                ),
                                ...semester['books'].map<TableRow>((book) {
                                  return TableRow(
                                    children: book
                                        .map<Widget>(
                                            (cellText) => tableCell(cellText))
                                        .toList(),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 400),
                        firstCurve: Curves.easeOut,
                        secondCurve: Curves.easeIn,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
