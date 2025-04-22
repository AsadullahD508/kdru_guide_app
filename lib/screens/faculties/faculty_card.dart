// import 'package:flutter/material.dart';
// import 'package:test_teacher/widgets/custom_header.dart';
// import 'package:test_teacher/screens/faculties/faculty_list.dart';
// import 'package:test_teacher/screens/faculties/Csfaculty/CSfaculty.dart';
//
// import 'Csfaculty/CsFaculty.dart';
// import 'engineering/engineering_faculty_screen.dart';
// import 'medicine/medicine_faculty_screen.dart';
// import 'agriculture/agriculture_faculty_screen.dart';
//
// class FacultyCard extends StatelessWidget {
//   const FacultyCard({super.key});
//
//   Widget _buildFacultyCard(BuildContext context, FacultyData faculty) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(Icons.school, size: 32, color: Colors.black),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               faculty.name,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               faculty.description,
//               style: const TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildStatItem(faculty.departments, 'Departments'),
//                 _buildStatItem(faculty.staff, 'Staff'),
//               ],
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Navigate to the appropriate faculty screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => _getFacultyScreen(faculty.name),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('View Details', style: TextStyle(color: Colors.white)),
//                     SizedBox(width: 8),
//                     Icon(Icons.arrow_forward, color: Colors.white, size: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatItem(String number, String label) {
//     return Column(
//       children: [
//         Text(
//           number,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 14, color: Colors.black54),
//         ),
//       ],
//     );
//   }
//
//   Widget _getFacultyScreen(String facultyName) {
//     switch (facultyName) {
//       case 'Faculty of Computer Science':
//         return const Scfaculty();
//       case 'Faculty of Engineering':
//         return const Scfaculty();
//       case 'Faculty of Medicine':
//         return const Scfaculty();
//       case 'Faculty of Agriculture':
//         return const Scfaculty();
//       default:
//         return const Scfaculty(); // Default to CS faculty for now
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomHeader(title: 'Faculties', selectedIndex: 1),
//       body: ListView.builder(
//         itemCount: faculties.length,
//         itemBuilder: (context, index) {
//           return _buildFacultyCard(context, faculties[index]);
//         },
//       ),
//     );
//   }
// }
