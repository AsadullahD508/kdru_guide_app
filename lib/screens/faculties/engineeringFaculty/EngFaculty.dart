import 'package:flutter/material.dart';
import '../../../widgets/custom_header.dart';
import 'Engineering_department.dart';

class EngFaculty extends StatelessWidget {
  const EngFaculty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(
        title: 'انجینري فاکولته',
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
                      'انجینري فاکولته',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B66),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'د ټکنالوژۍ راتلونکی مشران د کیفیت زده کړې، نوښتګرې څېړنې، او د انجینري اصولو عملي غوښتنلیک له لارې ځواکمنول.',
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
                              child: _buildStatCard('ډپارټمنټونه', '4'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard('ښوونکي', '6'),
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
          'ډپارټمنټونه',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
          ),
        ),
        const SizedBox(height: 16),
        _buildDepartmentCard(
          context,
          'سافټویر انجینري',
          'د سافټویر پراختیا میتودولوژۍ، ډیزاین نمونې، او سافټویر معمارۍ تمرکز.',
          '8 ښوونکي',
          '12 کورسونه',
        ),
        const SizedBox(height: 24),
        _buildDepartmentCard(
          context,
          'برقی انجینري',
          'د برقی سیستمونو، سرکټونو، او نوي انرژی ټیکنالوژیو مطالعه.',
          '5 ښوونکي',
          '10 کورسونه',
        ),
        const SizedBox(height: 24),
        _buildDepartmentCard(
          context,
          'مدني انجینري',
          'د فزیکي زیربناوو ډیزاین، جوړښت، او ساتنه.',
          '7 ښوونکي',
          '9 کورسونه',
        ),
        const SizedBox(height: 24),
        _buildDepartmentCard(
          context,
          'میکانیکي انجینري',
          'د میکانیکي سیستمونو او وسایلو ډیزاین او جوړول.',
          '6 ښوونکي',
          '11 کورسونه',
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
                  builder: (context) =>
                      EconomicDepartment(departmentName: title),
                ),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('د ډپارټمنټ لیدنه'),
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
