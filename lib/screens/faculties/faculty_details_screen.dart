// import 'package:flutter/material.dart';
// import '../../widgets/custom_header.dart';
// import '../../../widgets/custome_footer.dart';
//
// import '../Departement/Departement.dart';
// import 'computer_science/teacher_screen.dart';
//
// class FacultyDetailsScreen extends StatelessWidget {
//   final String facultyName;
//   final String description;
//   final int departments;
//   final int staff;
//   final IconData icon;
//
//   const FacultyDetailsScreen({
//     super.key,
//     required this.facultyName,
//     required this.description,
//     required this.departments,
//     required this.staff,
//     required this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomHeader(title: 'Faculty Details', selectedIndex: 1),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         height: 200,
//                         width: double.infinity,
//                         color: const Color(0xFF0D3B66),
//                       ),
//                       Positioned(
//                         bottom: 20,
//                         left: 20,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Faculty of $facultyName',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               description,
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Overview',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF0D3B66),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'The Faculty of $facultyName at Kandahar University is dedicated to providing quality education and fostering innovation in the field. Our experienced faculty members and state-of-the-art facilities ensure students receive the best possible education.',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             height: 1.5,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         const SizedBox(height: 32),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildStatCard(
//                                 'Departments',
//                                 departments.toString(),
//                                 Icons.business,
//                                 Colors.blue,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: _buildStatCard(
//                                 'Staff Members',
//                                 staff.toString(),
//                                 Icons.people,
//                                 Colors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 32),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => DepartmentScreen(
//                                         departmentName: facultyName,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xFF0D3B66),
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 16,
//                                   ),
//                                 ),
//                                 child: const Text('View Departments'),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ComputerScienceTeacherScreen(),
//                                     ),
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 16,
//                                   ),
//                                 ),
//                                 child: const Text('View Teachers'),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const CustomFooter(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatCard(
//     String label,
//     String value,
//     IconData icon,
//     Color color,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 32),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(fontSize: 14, color: color.withOpacity(0.8)),
//           ),
//         ],
//       ),
//     );
//   }
// }
