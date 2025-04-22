// import 'package:flutter/material.dart';
// import '../../widgets/custom_header.dart';
//
// class DepartmentScreen extends StatelessWidget {
//   final String departmentName;
//   final String description;
//   final int facultyMembers;
//   final int researchLabs;
//   final int courses;
//   final List<Map<String, String>> faculty;
//
//   const DepartmentScreen({
//     super.key,
//     required this.departmentName,
//     required this.description,
//     required this.facultyMembers,
//     required this.researchLabs,
//     required this.courses,
//     required this.faculty,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomHeader(
//         title: departmentName,
//         selectedIndex: 1,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             _buildStats(),
//             _buildDescription(),
//             _buildFacultySection(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       color: const Color(0xFF0D3B66),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             departmentName,
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Department',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.white.withOpacity(0.8),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStats() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildStatItem(facultyMembers.toString(), 'Faculty Members'),
//           _buildStatItem(researchLabs.toString(), 'Research Labs'),
//           _buildStatItem(courses.toString(), 'Courses'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatItem(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF0D3B66),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDescription() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'About the Department',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0D3B66),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             description,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.black87,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFacultySection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Faculty Members',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0D3B66),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: faculty.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundImage: NetworkImage(
//                           faculty[index]['image'] ??
//                               'https://via.placeholder.com/60',
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               faculty[index]['name'] ?? '',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               faculty[index]['position'] ?? '',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               faculty[index]['specialization'] ?? '',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
