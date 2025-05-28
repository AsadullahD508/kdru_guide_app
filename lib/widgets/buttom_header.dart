import 'package:flutter/material.dart';
import '../home.dart';
import '../screens/Faculty/facultycard.dart';
import '../screens/home_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 0, 'کور صفحه', context),
          _buildNavItem(Icons.account_balance_rounded, 1, 'پوهنځي', context),
          _buildNavItem(Icons.school, 2, 'پوهنتون', context),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, int index, String label, BuildContext context) {
    bool isSelected = index == selectedIndex;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            onItemTapped(index);

            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FirstHomescreen(),
                ),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FacultyCard(),
                ),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homescreen(selectedIndex: 2),
                ),
              );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: isSelected
                ? Matrix4.translationValues(0, -10, 0)
                : Matrix4.identity(),
            child: Icon(
              icon,
              color: isSelected ? Colors.lightBlue : Colors.black,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.lightBlue : Colors.black,
            fontFamily: 'pashto',
          ),
        ),
      ],
    );
  }
}
