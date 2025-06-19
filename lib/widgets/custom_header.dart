import 'package:flutter/material.dart';
import '../screens/Faculty/facultycard.dart';
import '../home.dart';
import '../screens/profile/profile_screen.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int selectedIndex;

  const CustomHeader({
    super.key,
    required this.title,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D3B66),
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          color: selectedIndex == 0 ? Colors.white : Colors.white60,
          onPressed: () {
            if (selectedIndex != 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FirstHomescreen()),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.school),
          color: selectedIndex == 1 ? Colors.white : Colors.white60,
          onPressed: () {
            if (selectedIndex != 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FacultyCard()),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.person),
          color: selectedIndex == 2 ? Colors.white : Colors.white60,
          onPressed: () {
            if (selectedIndex != 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TeamProfilePage()),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
