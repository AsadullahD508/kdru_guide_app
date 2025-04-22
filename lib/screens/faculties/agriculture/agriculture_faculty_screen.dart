import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';

class AgrFaculty extends StatelessWidget {
  const AgrFaculty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(
        title: 'Agriculture Faculty',
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
                      'Faculty of Agriculture',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Cultivating knowledge and innovation in agricultural sciences to ensure food security and sustainable development.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 800) {
                          return Column(
                            children: [
                              _buildDepartmentsSection(),
                              const SizedBox(height: 40),
                            ],
                          );
                        } else {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildDepartmentsSection()),
                              const SizedBox(width: 40),
                            ],
                          );
                        }
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

  Widget _buildStatCard(String title, String value) {
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

  Widget _buildDepartmentsSection() {
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
          'Agronomy',
          'Focus on crop production, soil management, and sustainable farming practices.',
          '6 Teachers',
          '10 Courses',
        ),
        const SizedBox(height: 24),
        _buildDepartmentCard(
          'Animal Science',
          'Studies related to livestock, dairy production, and animal breeding.',
          '4 Teachers',
          '8 Courses',
        ),
      ],
    );
  }

  Widget _buildDepartmentCard(
    String title,
    String description,
    String teacherCount,
    String courseCount,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Row(
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
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
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
