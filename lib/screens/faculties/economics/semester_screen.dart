import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custome_footer.dart';

class SemesterScreen extends StatelessWidget {
  const SemesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(
        title: 'Semester Information',
        selectedIndex: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextbooksSection(),
                  const SizedBox(height: 24),
                  _buildDepartmentStructure(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextbooksSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Required Textbooks for Computer Science Program',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
              ),
            ),
            const SizedBox(height: 16),
            for (int i = 1; i <= 8; i++) _buildSemesterTextbooks(i),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterTextbooks(int semester) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Year ${((semester - 1) ~/ 2) + 1}, Semester ${semester % 2 == 0 ? 2 : 1}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
          ),
        ),
        const SizedBox(height: 8),
        ..._getTextbooksForSemester(semester).asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D3B66),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        'images/kdr.jpg',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(entry.value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  List<String> _getTextbooksForSemester(int semester) {
    switch (semester) {
      case 1:
        return [
          'Introduction to Programming with Python by John Smith',
          'Computer Science Fundamentals by Sarah Johnson',
          'Python Programming for Beginners by David Brown',
          'Data Structures in Python by Lisa Adams',
          'Introduction to Algorithms by Thomas H. Cormen',
        ];
      case 2:
        return [
          'Computer Science: An Overview by Glenn Brookshear',
          'Data Structures and Algorithms by Mark Allen Weiss',
          'Discrete Mathematics by Kenneth H. Rosen',
          'Operating Systems Concepts by Abraham Silberschatz',
          'Computer Networks by Andrew S. Tanenbaum',
        ];
      case 3:
        return [
          'Java Programming for Beginners by Peter Jones',
          'Introduction to Software Engineering by Ian Sommerville',
          'Database Management Systems by Raghu Ramakrishnan',
          'Web Technologies by Jeffrey C. Jackson',
          'Data Mining by Jiawei Han',
        ];
      case 4:
        return [
          'Advanced Python Programming by Mark Lutz',
          'Computer Organization and Design by David A. Patterson',
          'Algorithms in C by Robert Sedgewick',
          'Operating Systems by William Stallings',
          'Software Engineering: A Practitioner’s Approach by Roger Pressman',
        ];
      case 5:
        return [
          'Database Systems Concepts by Abraham Silberschatz',
          'Artificial Intelligence: A Modern Approach by Stuart Russell',
          'Machine Learning by Tom M. Mitchell',
          'Discrete Mathematics and Its Applications by Kenneth Rosen',
          'Digital Design by M. Morris Mano',
        ];
      case 6:
        return [
          'Web Development with Node.js by Brad Traversy',
          'Computer Networks by James F. Kurose',
          'Machine Learning Yearning by Andrew Ng',
          'Introduction to Cloud Computing by Judith Hurwitz',
          'Compilers: Principles, Techniques, and Tools by Alfred V. Aho',
        ];
      case 7:
        return [
          'Deep Learning by Ian Goodfellow',
          'Cloud Computing: Principles and Paradigms by Rajkumar Buyya',
          'Principles of Distributed Computing by M. J. Atallah',
          'The Art of Computer Programming by Donald E. Knuth',
          'Database Management Systems by Raghu Ramakrishnan',
        ];
      case 8:
        return [
          'Design and Analysis of Algorithms by Anany Levitin',
          'Data Science from Scratch by Joel Grus',
          'Introduction to the Theory of Computation by Michael Sipser',
          'Computer Vision: Algorithms and Applications by Richard Szeliski',
          'Big Data: A Revolution That Will Transform How We Live, Work, and Think by Viktor Mayer-Schönberger',
        ];
      default:
        return [];
    }
  }

  Widget _buildSemesterCard(
    String title,
    String status,
    bool isCurrent,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D3B66),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isCurrent ? Colors.green[100] : Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isCurrent ? Colors.green[700] : Colors.blue[700],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Duration:', '4 months'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentStructure() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Department Structure',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Each department follows an 8-semester structure over 4 years:',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            _buildStructurePoint('Every semester contains 5 courses'),
            _buildStructurePoint('Each course is 4 credit hours'),
            _buildStructurePoint('20 credit hours total per semester'),
            _buildStructurePoint('All 4 years have 160 credits'),
            _buildStructurePoint(
                'All courses follow 20-30% attendance and continuous assessment policies'),
          ],
        ),
      ),
    );
  }

  Widget _buildStructurePoint(String point) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 10,
            color: Color(0xFF0D3B66),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(point)),
        ],
      ),
    );
  }
}
