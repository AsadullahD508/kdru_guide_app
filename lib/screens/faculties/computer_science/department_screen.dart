import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custome_footer.dart';
import 'teacher_screen.dart';

class ComputerScienceDepartmentScreen extends StatelessWidget {
  const ComputerScienceDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'CS Departments', selectedIndex: 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Computer Science Departments',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'The Computer Science Faculty offers comprehensive programs across various specializations. Our departments are equipped with modern facilities and led by experienced professionals.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Row(
                      children: [
                        _StatCard(
                          icon: Icons.people,
                          label: 'Faculty Members',
                          value: '28',
                          color: Colors.blue,
                        ),
                        SizedBox(width: 16),
                        _StatCard(
                          icon: Icons.science,
                          label: 'Research Labs',
                          value: '5',
                          color: Colors.green,
                        ),
                        SizedBox(width: 16),
                        _StatCard(
                          icon: Icons.school,
                          label: 'Programs',
                          value: '4',
                          color: Colors.purple,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Our Departments',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDepartmentCard(
                      'Software Engineering',
                      'Focus on software development methodologies, design patterns, and software architecture.',
                      '8 Faculty Members',
                      '12 Courses',
                    ),
                    const SizedBox(height: 16),
                    _buildDepartmentCard(
                      'Computer Networks',
                      'Specializing in network architecture, security, and cloud computing.',
                      '6 Faculty Members',
                      '10 Courses',
                    ),
                    const SizedBox(height: 16),
                    _buildDepartmentCard(
                      'Artificial Intelligence',
                      'Research and education in machine learning, data science, and AI applications.',
                      '7 Faculty Members',
                      '8 Courses',
                    ),
                    const SizedBox(height: 16),
                    _buildDepartmentCard(
                      'Information Systems',
                      'Focus on database management, information security, and business intelligence.',
                      '7 Faculty Members',
                      '9 Courses',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard(
    String title,
    String description,
    String facultyCount,
    String courseCount,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.people, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  facultyCount,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(width: 24),
                Icon(Icons.book, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  courseCount,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
