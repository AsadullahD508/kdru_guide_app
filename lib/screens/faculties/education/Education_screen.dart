import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';
import '../../Departement/Departement.dart';
// Add this import

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(
        title: 'Engineering',
        selectedIndex: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Engineering Faculty',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Empowering the future technology leaders through quality education, innovative research, and practical application of engineering principles.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Statistics Cards
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildStatCard('Departments', '4'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard('Teachers', '6'),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Departments Section
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return constraints.maxWidth < 800
                            ? Column(
                                children: [
                                  _buildDepartmentsSection(context),
                                  const SizedBox(height: 40),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B66),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDepartmentsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Departments',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
          ),
        ),
        const SizedBox(height: 16),
        _buildDepartmentCard(
          context,
          'Software Engineering',
          'Focus on software development methodologies, design patterns, and software architecture.',
          '8 Teachers',
          '12 Courses',
        ),
        const SizedBox(height: 24),
        _buildDepartmentCard(
          context,
          'Electrical Engineering',
          'Study of electrical systems, circuits, and renewable energy technologies.',
          '5 Teachers',
          '10 Courses',
        ),
        const SizedBox(height: 24),
        _buildDepartmentCard(
          context,
          'Civil Engineering',
          'Focus on designing, building, and maintaining physical infrastructure.',
          '7 Teachers',
          '9 Courses',
        ),
        const SizedBox(height: 24),
        _buildDepartmentCard(
          context,
          'Mechanical Engineering',
          'Design and manufacturing of mechanical systems and devices.',
          '6 Teachers',
          '11 Courses',
        ),
      ],
    );
  }

  static Widget _buildDepartmentCard(
    BuildContext context,
    String title,
    String description,
    String teacherCount,
    String courseCount,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B66),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.people, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  teacherCount,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 24),
                Icon(Icons.book, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  courseCount,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepartmentScreen(departmentName: title),
                ),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View Department'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
