import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../header.dart';
import '../../../../widgets/buttom_header.dart';

class AllTeachersScreen extends StatefulWidget {
  final Map<String, dynamic> facultyData;

  const AllTeachersScreen({super.key, required this.facultyData});

  @override
  State<AllTeachersScreen> createState() => _AllTeachersScreenState();
}

class _AllTeachersScreenState extends State<AllTeachersScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // تاسو دلته کولی شئ هر bottom nav page ته لاړ شئ
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: Column(
          children: [
            CustomHeader(
              userName: 'Guest User',
              bannerImagePath:
                  widget.facultyData['backgroundUrl'] ?? 'images/kdr_logo.png',
              fullText: widget.facultyData['name'] ?? 'پوهنځی',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collectionGroup('teachers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            'د استادانو په ترلاسه کولو کې ستونزه رامنځته شوه.'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final teachers = snapshot.data!.docs;

                  if (teachers.isEmpty) {
                    return const Center(child: Text('هیڅ استاد ونه موندل شو.'));
                  }

                  return ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      final teacherData =
                          teachers[index].data() as Map<String, dynamic>;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(teacherData['photoUrl'] ?? ''),
                          ),
                          title: Text(
                            teacherData['name'] ?? '',
                            style: const TextStyle(fontFamily: 'pashto'),
                          ),
                          subtitle: Text(
                            teacherData['position'] ?? '',
                            style: const TextStyle(fontFamily: 'pashto'),
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
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: _onItemTapped,
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }
}
