import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';

import '../../../widgets/custome_footer.dart';
import '../computer_science/teacher_screen.dart';

class DepartmentScreen extends StatelessWidget {
  final String departmentName;

  const DepartmentScreen({super.key, required this.departmentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Department', selectedIndex: 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Department of $departmentName',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'The Engineering Department at Kandahar University offers comprehensive programs in civil, electrical, and mechanical engineering. Our faculty consists of experienced professionals dedicated to providing quality education and practical training to prepare students for successful careers in engineering.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add semester information functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D3B66),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today, size: 20),
                                SizedBox(width: 8),
                                Text('View Semester Information'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ComputerScienceTeacherScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.people, size: 20),
                                SizedBox(width: 8),
                                Text('View Teachers'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Row(
                      children: [
                        _StatCard(
                          icon: Icons.people,
                          label: 'Faculty Members',
                          value: '20',
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
                          label: 'Courses',
                          value: '12',
                          color: Colors.purple,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Programs Offered',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProgramCard(
                      'Bachelor of Engineering',
                      'A 4-year undergraduate program covering fundamental and advanced engineering concepts.',
                      Icons.engineering,
                    ),
                    const SizedBox(height: 16),
                    _buildProgramCard(
                      'Master of Engineering',
                      'Advanced graduate program focusing on specialized engineering disciplines.',
                      Icons.school,
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

  static Widget _buildProgramCard(
      String title, String description, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF0D3B66)),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D3B66),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
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
