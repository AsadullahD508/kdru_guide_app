import 'package:flutter/material.dart';

import '../screens/faculties/computer_science/faculty_screen.dart';
import '../screens/Faculty/engineeringFaculty/EngFaculty.dart';
// import 'package:Kdru_Guide_app/screens/faculties/education/education_home.dart';
// import '../screens/faculties/journalism/journalism_home.dart';
// import '../screens/faculties/public_admin/public_admin_home.dart';
// import '../screens/faculties/law/law_home.dart';
// import '../screens/faculties/shariat/shariat_home.dart';
// import '../screens/faculties/economics/economics_home.dart';
// import '../screens/faculties/medicine/medicine_home.dart';
//import '../screens/faculties/literature/literature_home.dart';

class FacultyRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/faculty/cs': (context) => const CsFaculty(),
    '/faculty/engineering': (context) => const EngineeringFaculty(),
    // '/faculty/education': (context) => const EducationFaculty(),
    // '/faculty/journalism': (context) => const JournalismFaculty(),
    // '/faculty/public-admin': (context) => const PublicAdminFaculty(),
    // '/faculty/law': (context) => const LawFaculty(),
    // '/faculty/shariat': (context) => const ShariatFaculty(),
    // '/faculty/economics': (context) => const EconomicsFaculty(),
    // '/faculty/medicine': (context) => const MedicineFaculty(),
    // '/faculty/literature': (context) => const LiteratureFaculty(),
  };
}
