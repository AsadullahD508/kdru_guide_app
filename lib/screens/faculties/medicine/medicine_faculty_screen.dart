import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';

class MedFaculty extends StatelessWidget {
  const MedFaculty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(
        title: 'Cs faculty',
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
                      'Faculty of Computer Science',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Empowering the future technology leaders through quality education, innovative research, and practical application of computer science principles.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Statistics Cards with more spacing
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return constraints.maxWidth < 600
                            ? Row(
                                children: [
                                  _buildStatCard('Departments', '4'),
                                  const SizedBox(
                                      height: 24), // Increased spacing
                                  _buildStatCard('Teachers', '6'),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: _buildStatCard('Departments', '4'),
                                  ),
                                  const SizedBox(
                                      width: 32), // Increased spacing
                                  Expanded(
                                    child: _buildStatCard('Teachers', '6'),
                                  ),
                                ],
                              );
                      },
                    ),
                    const SizedBox(height: 40), // Increased spacing

                    // Departments and Teachers Section
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return constraints.maxWidth < 800
                            ? Column(
                                children: [
                                  _buildDepartmentsSection(),
                                  const SizedBox(
                                      height: 40), // Increased spacing
                                ],
                              )
                            : const Row(
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
          'Software Engineering',
          'Focus on software development methodologies, design patterns, and software architecture.',
          '8 Teachers',
          '12 Courses',
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

  Widget _buildTeacherCard(
    String name,
    String title,
    String email,
    String phone,
    String officeHours,
    String specialization,
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
          LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth < 400
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://via.placeholder.com/100',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://via.placeholder.com/100',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(height: 16),
          _buildContactInfo(Icons.email, email),
          _buildContactInfo(Icons.phone, phone),
          _buildContactInfo(Icons.access_time, officeHours),
          _buildContactInfo(Icons.school, specialization),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
