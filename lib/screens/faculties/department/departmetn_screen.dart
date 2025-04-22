import 'package:flutter/material.dart';
import '../../../widgets/custome_footer.dart';
import '../../../widgets/custom_header.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(
        title: 'Department of Engineering',
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
                      'Department of Engineering',
                      style: TextStyle(
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
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Statistics Row
                    Row(
                      children: [
                        _buildStatCard('Faculty Members', '20'),
                        const SizedBox(width: 16),
                        _buildStatCard('Research Labs', '5'),
                        const SizedBox(width: 16),
                        _buildStatCard('Courses', '12'),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // View Semester Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D3B66),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Semester Information',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Faculty Members Section
                    const Text(
                      'Faculty Members',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFacultyMemberCard(
                      'Dr. Aisha Patel',
                      'Associate Professor',
                      'Computer Science',
                      ['Algorithms', 'Machine Learning', 'Data Structures'],
                      'a.patel@university.edu',
                      '+1 (555) 456-7890',
                      'Technology Building, Room 118',
                      'Tue/Thu 9-11 AM',
                    ),
                    const SizedBox(height: 16),
                    _buildFacultyMemberCard(
                      'Dr. Emily Rodriguez',
                      'Assistant Professor',
                      'Literature',
                      ['World Literature', 'Creative Writing', 'Poetry'],
                      'e.rodriguez@university.edu',
                      '+1 (555) 234-5678',
                      'Liberal Arts Building, Room 415',
                      'Mon/Fri 10 AM-12 PM',
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

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacultyMemberCard(
    String name,
    String position,
    String department,
    List<String> specializations,
    String email,
    String phone,
    String office,
    String officeHours,
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
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://via.placeholder.com/100',
                  width: 80,
                  height: 80,
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
                    Text(
                      '$position - $department',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: specializations
                .map((spec) => Chip(
                      label: Text(spec),
                      backgroundColor: Colors.blue[50],
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          _buildContactInfo(Icons.email, email),
          _buildContactInfo(Icons.phone, phone),
          _buildContactInfo(Icons.location_on, office),
          _buildContactInfo(Icons.access_time, officeHours),
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
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
